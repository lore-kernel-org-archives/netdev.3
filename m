Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6045D92B
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300650; cv=none; b=GF2d14e6W0wyfBEbVPNQnkeRoQRkxazA0eFIwv91kJBfE9Gy249/u1Whtnky4jWD2eMNp6ZWQ33MyYFquiqtiFjRmQKcriJlvxtljLwLR+Ukpv27R4U4za37XGZPVJLnTLgJNq0ryehxyfHM8RDpHYqz9Qj3O0o9r12Wzl0/WHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300650; c=relaxed/simple;
	bh=m1+/e0RfrynId38IUPr0WpQw1p8W5lf57aYm0LWtddE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN2+SKpbPdoRPHn0fgZ6rWZ4jYdywfmS2lhbz+r1v0GSnaFpl3zEzr5YmksM5qqwKuhVjLji5L9NDTN6RqOKk99YXNANl+MMDTJCbiXBeRDw7LV/yluOBLSUqdn4HTsoG9J4Zped0VF1TBdPKCkwCnDiR8OLP8Yz7WMlBIYC2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvqTUeEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvqTUeEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CDC1F0089B;
	Tue,  6 Oct 2026 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791300648;
	bh=auABOYcQ94uUoT7JSgrvfzqh9UYMOH31EMmDcgigAMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JvqTUeEsF5pdT1EZns112KUPZ5rdfER0JzNDhJ74xmnTAYJo0Pu40wzSqUavteccG
	 WpH3RrF2CwcRgNF9plMo7J0TJbj8TxaAjdYeQnPzPT81tAmrpmbjN+wgcztH+04ws9
	 3NMPzjKiT5AD3YTFrXlaHxytl0GRijYTiJUf1hVHknSyRjqSnGpVbVuei8hB8w1o7k
	 bdzsMBNZp6JjTgBEVNVdDFSAjXX4dl7/VwijuVHfGy93M/l9IyzXB8s/B38C+TNiVN
	 4fJmlI4s7acMN554hS2VrjiqQcKv57Y35b7ymVc4etlxYI8Fkql6Aj3kbZ5+nsNd/i
	 8ToPo2vqTItOA==
Date: Tue, 6 Oct 2026 16:30:43 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	moeller0@gmx.de, cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v4] net/sched: cap the accounted backlog before
 it can wrap
Message-ID: <20261006153043.GM83879@horms.kernel.org>
References: <QDISC-BA27.v4.20261001193440@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-BA27.v4.20261001193440@mojatatu.com>

On Fri, Oct 02, 2026 at 03:44:31AM -0400, Jamal Hadi Salim wrote:

...

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c

...

> @@ -1712,18 +1738,24 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
>  	return &qd->tins[tin];
>  }
>  
> -static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
> -			 struct sk_buff *skb, int flow_mode, int *qerr)
> +/* Run the optional external classifier. Returns true when the packet was
> + * consumed by a terminal TC action (reason in *qerr); else *flow/*host

FYI:

W=1 builds complain that the line above has a '/*' embedded in a comment.
This is likely why Sashiko NIPA didn't run for this series.

...

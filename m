Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FFA3563CD;
	Wed, 16 Sep 2026 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519724; cv=none; b=px4hERGgkjnUd2iCClWaUhtDEUPDGHnjxTyDVix11qlRbEloFwKJ+S5GLu3XuGufP6l+twX7FI6kAG3uS+yH89tmjFXpFWOI3DWDuKSev70MQIISO1j9fFsUbSDKh1E9UMALv+3KHlauV9WHV5Bp4VJh+3mymgcmTZX10UxabUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519724; c=relaxed/simple;
	bh=CWZAaWCVhrh92dZlXOVV0Cgwff1PjvnSV4yHvPThoLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxwfE2FW22Q5jPMWPHGT+k7wiSmX435pMa25zlcsnTCvEua/dqEV2j4stSAQsc3EuYFuCd9gXnOjgR0s1lPTY1QMmoi8lg5niNzdBIveqnz1p5QkRZ5dEZas3E/Ikcm5vg5+DpAD5Dv0KlxqeQRIsxg5dgC7ctLRj7srUsRNSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZFRzPl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZFRzPl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89E81F000FF;
	Wed, 16 Sep 2026 00:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519717;
	bh=zwSGxEJsXGq7U13gthDmY1h3f4ICZxjQntRtAG1kDWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GZFRzPl1JkvETNHJE0ROefs+VhOjBZja4wWyRt8xXlt0uMoGe00z1pZr90UAU/yvY
	 EiIybvjhETTLI+9BkLmaxCR6ZNjkeT1bTvbVxnxRXv5ruPGSSOxkEzonuuwNOYdQy0
	 kUye8J/4La+UyE7JdVpj7KoKBqD4qdzgVVCumFDoC2jEdavLau/gi7gHkG+C91Op2c
	 0iK062YXQQXdAVUcNV/OhI3AJdafACcjHYAZ8mtoq5VrQV/moXLq7e28Fi8KlvlY1Q
	 Xo4vUCYiayTSgBR5lP3QkPylXTqsHJADkbF02oGnCU2c6r9Hdgxyzru6aJ4dEK+hwh
	 krq0z5AQaWzyg==
Date: Tue, 15 Sep 2026 17:48:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ali Firas <alishmery18@gmail.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 razor@blackwall.org, roopa@nvidia.com, bestswngs@gmail.com, xmei5@asu.edu,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] vxlan: vnifilter: roll back VNI insertion
 when the group update fails
Message-ID: <20260915174836.464fae55@kernel.org>
In-Reply-To: <20260911215203.3054653-2-alishmery18@gmail.com>
References: <20260911215203.3054653-1-alishmery18@gmail.com>
	<20260911215203.3054653-2-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 00:52:03 +0300 Ali Firas wrote:
> Subject: [PATCH net v2 2/2] vxlan: vnifilter: roll back VNI insertion when the group update fails

Please trim the slop.
Ido may disagree but this looks like net-next material to me
-- 
pw-bot: cr

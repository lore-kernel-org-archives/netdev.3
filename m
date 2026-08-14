Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A6463B7E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709672; cv=none; b=JtCbt/RgL8GnFC/V0n/xv6D1NyhLpOjXmG3l7UBhbv/YOPKZVY1zYtjxZKCt8pJgxmm5CUhO71oiukxhiGaSjrwZAi1N+wPMQdIcNA0X7GxMH7MCwWLhh8v/Sevoo4vp9LKN6SvtcNapT1ozJvasfGw4QqhKVTXbLme1gMwh5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709672; c=relaxed/simple;
	bh=6xc4JhVmtnhSwu0D0J538FsnQ7L/YF3FppETHLlREa8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=pjQK1361UQXeAyosTY1Q8ibmUJ8SisxfAxh1wawihwh4LfDw70fAhi6dDXX9W2urVNtGtLMYpYGV7RnV/0TGazSKn/siDqJidnbOUZNCG9Uzf07Ui1PzyIc9dzX7dAelE7HttudxiN2kb+cSJFM5FS4nONc5uQ4Pg45Vt6TzB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LC1ke4Q/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LC1ke4Q/"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6xc4JhVmtnhSwu0D0J538FsnQ7L/YF3FppETHLlREa8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786709668; v=1; x=1787314468;
 b=LC1ke4Q/1IG8igYZOeVialRHhKa7k7qDBPLJVA1r+7dtt3Bmv+7TpSVyVVJOOgeUKZXjH+hq
 rhLlQNjb/GvDjOiSmG+EdqObQ/L7GqOKfjNFCDr4LK5tBy6p9dC5IQaJadBbYF+FwjO6s0hRHGR
 03LtBkVm5zofLa6WawvANNkE=
X-Envelope-To: netdev@vger.kernel.org
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id 528848ced92cc84f;
	Fri, 14 Aug 2026 12:14:28 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Aug 2026 12:14:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: vadim.fedorenko@linux.dev
Message-ID: <8213af42c3779472a1e1480a8a3fbbcfde6fe03f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next] ionic: Add .get_fec_stats ethtool handler
To: "Eric Joyner" <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: "Brett Creeley" <brett.creeley@amd.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Nikhil P . Rao" <nikhil.rao@amd.com>
In-Reply-To: <a834d76e-9b31-4241-9442-0a69ab96cfc1@amd.com>
References: <20260731214021.15279-1-eric.joyner@amd.com>
 <95d9b473-71ea-4324-b673-db68140782fa@linux.dev>
 <a834d76e-9b31-4241-9442-0a69ab96cfc1@amd.com>

On 14/08/2026 05:42, Eric Joyner wrote:
> On 8/4/2026 3:27 AM, Vadim Fedorenko wrote:
>> Caution: This message originated from an External Source. Use proper c=
aution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 31/07/2026 22:40, Eric Joyner wrote:
>>> Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane =
counts
>>> currently aren't supported, and the only expected histogram format fr=
om
>>> firmware is the one with 16 bins from RS(544,514) FEC.
>>
>> does it mean the FW will return IONIC_STAT_INVALID for 100G CWDM4 mode
>> on newest devices?
>>
>>
> > The only device we have that supports reporting these FEC histograms =
doesn't
> have a PHY that supports 100G CWDM4; the IP block for it only supports =
PAM4
> media types and not NRZ. So for now, it would return IONIC_STAT_INVALID=
 for
> that mode.
> > Though, I don't know if that'll be the case for future devices; maybe=
 they will
> support FEC histogram stat collection with NRZ media that has fewer tha=
n 16
> histogram bins. I just don't know if it's worth supporting that possibi=
lity
> right now since I don't know when or if that will happen.

Ok, thanks for explaining.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

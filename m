Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA43EFD31
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971937; cv=none; b=Q6U/kO552FdiK0yA46huQ0TmxxRXNO77pjO5JQaGtIASsOxN5dZqb7FwEaZfVh9sh8K3cTnBUCn4+ATFbo/QWAxgHww410HUsHiWFu9Qp6AeNimCEU7EzdreLBv4PBZR9Ry5UQZVwCQbC81MaqePdvsJUYtvSTiQdGi00qaME34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971937; c=relaxed/simple;
	bh=vwBGLX8h6iLk705rL2Tl7KzGWO+/CZVfndSVKv16qos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opMA8scK5N0p8ZvV5fhXV5Vgu0QGwRzlKPzaOJSzQT9IT/8LO1hsK5rQD9cNtRBZOqAZEm68Avse/Ez5miQupULImS7KWMthjbN2PV19UBzk/Y6krgvDzL5zlaC/EiTnoE2IGNA0KiUqsO1GPJpuEMSkf18K5uOzE/VJJ4a5Rtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=C5IigB1O; arc=none smtp.client-ip=188.68.63.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="C5IigB1O"
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4gR5R96mmZz8fHT;
	Thu, 28 May 2026 12:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779971398;
	bh=vwBGLX8h6iLk705rL2Tl7KzGWO+/CZVfndSVKv16qos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C5IigB1OiA0WmdMABgcLRcjWZ9yU1xqjiwpICBjCEVWiv5GXxKwqLr9R+pfK2a0/J
	 +Apg4diUog63YvTIUuZ7bidjgEP4ahOdnnjOz1ZVUmBynorfICHSyK4jT6ZTHDXqw3
	 ryyc9f5yb1QijScbkCe+GTcJnXJgCCuxJ1InnUchhfK+cQu9k2jF52Vv5dYKdTR0py
	 uNE9R3iQAt/egUqEImMSyu3RTNHZo8XY9mMnIv6JDASMCP+6AQq483eH7krjktBOSl
	 6BQsacLNU5jh6Fy4bpIPls5nNm/Vi48LSWsxmocUP6o9WkR3w6oKMr2YROyEG7XJLs
	 qfV1rWh01LaDA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4gR5R961wSz8f9n;
	Thu, 28 May 2026 12:29:57 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gR5R9139gz8sb8;
	Thu, 28 May 2026 14:29:55 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id EACEA60345;
	Thu, 28 May 2026 14:29:51 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
Date: Thu, 28 May 2026 14:29:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with IPv6 privacy addresses in 7.0
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 Stefano Brivio <sbrivio@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Justin Iurman <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>,
 David Gibson <david@gibson.dropbear.id.au>, ihuguet@redhat.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260521135310.GC977@cmadams.net>
 <20260526175743.1f2c3761@kernel.org> <20260527010641.GA21073@cmadams.net>
 <20260526183122.348e44e7@kernel.org> <20260527215135.GB16443@cmadams.net>
 <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth>
 <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
 <20260528131250.1352ab48@elisabeth>
 <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177997139332.4113405.5375636487276538211@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: EACEA60345
X-NC-CID: k9sWVK1yFabwxEGPmbbIq97D2AE80F1k/dal1pUPxg/vrnDlscE=

On 5/28/26 13:29, Fernando Fernandez Mancera wrote:
> On 5/28/26 1:12 PM, Stefano Brivio wrote:
>> On Thu, 28 May 2026 12:46:05 +0200
>> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>>> On 5/28/26 7:38 AM, Stefano Brivio wrote:
>
>> - regardless of this, would there be a way to make NetworkManager
>>    robust to the order?
>>
>>    I'm asking this because yes, strictly speaking, you might say this
>>    change breaks userspace (NetworkManager), but at the same time it
>>    fixes another part of it (pasta), and changing it back would break
>>    pasta again (in a way we can't really fix).
>
> Ugh, that is a mess.

Well, yes, but one that happens regularly. :-D

The problem here is that it was reported only some months after the
culprit landed, as fixing the regression through a revert or so could
now cause a bigger regression. Do we assume this to be the case here? It
sounds like pasta would "only" be broken about as much as it was before
-- then a revert or something like that is the right solution to get
back to the status quo. Or does pasta already depend on the new behavior
somehow and would now break even more if we reverted the culprit? Then
it's really a mess. :-/

But there are ways to fix even this, it's just that most of them are
ugly. Like adding some bit somewhere to /proc/ or so that a fixed
NetworkManager (if it's the only affected app) could flip by default to
change the things from the old behavior to the new one; and one pasta
could check that bit and warn. Config options are also an option, but
that's even uglier.

>>    Now, I suppose NetworkManager is much more universally used and it's
>>    definitely a more mature project so it's a bigger userspace breakage,
>>    but at the same time it's a ton of containers (Podman uses pasta by
>>    default, Docker/moby optionally via rootlesskit) we might introduce a
>>    regression for.
> 
> I think the main argument here is: while we know it is affecting
> NetworkManager, we cannot know if it is breaking something else. The
> kernel rule is usually "do not break userspace" and this is likely
> considered a regression from my understanding. Cc'ing Thorsten as he is
> an expert on regressions.

From the mail at the top of the thread it definitely sounds like one.

Ciao, Thorsten

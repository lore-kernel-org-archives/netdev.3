Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927914848AE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849438; cv=none; b=Rd0BO/wou42cdoICMvpd/vl1gskM05UtnJ0Z0EETF9+LNN2U8Kr5ZKKM+yJXQT1V816vYUBIFlrp8+i5iA6mRNiRaIqmIW897BcAOvlgR0O9zzWpHXzXYwudWj363ULH3058PDuIqZ/GKYzYbiOAG9lvQR29HCut9AQXiAebDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849438; c=relaxed/simple;
	bh=PNn+ifeJ9JG8nAUNl8P71GOM2JrM84XXQounsmfM4wM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBK6EA8r5q4OlRARQhY4IrbJ4WdGkb+NtyhhpKx7xedp1VBJBorHmzupA4+jV69Co+TT+ci4XePHBPVTypKPIftV1EsnHZo4NfWSlQ9t7ZCMZ485qbWK1Y6wOmliUzkPNJ0gzm0wSRLqHslJEPQWwNT7Q7OA9UJniiZC9vwuyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuMYN3fx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuMYN3fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A262E1F00898;
	Thu,  1 Oct 2026 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849428;
	bh=oM3Rf/hJ1hs27M7cPIkP2fp3x5YoxK2XjVR3AlTbgGQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AuMYN3fxDGxwyVTRDwT1qHo+WFsXeyEdiJRCCrZrjiyQJsv/A7V1lbeQgCsfs8K1s
	 xtXLKCAkTeNFJWjD4e+WCg5LwGcZFohIRbipQ96OzBXGhCTpRGPkPklMqX4au5IfNx
	 xLDFb0+BCTSJPFDzIyyVkw1rnaYvLLyozc4/KWSbzfJDSGOHyHkkIG5i542HvFaUmC
	 cFcuVJhD6NGQxU4mbmmxqATfXMdOfQpyjuQhnsXOfsoRuZ82yCx8mwuIDf0SPU7mMQ
	 L4nTmO1p9wheMHJlJdWr0OXgCNzTiiGrY+Waw0KHX85P15y44hdsu/YuJUTcff160t
	 JxUm3bNJchYig==
Subject: Re: [PATCH net-next 3/9] batman-adv: tt: clarify responsibility for
 roam flag during removal
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Thu, 01 Oct 2026 10:10:27 +0000
Message-ID: <179084942724.434549.1630601702570339695@kernel.org>
In-Reply-To: <20260930094558.3723766-4-sw@simonwunderlich.de>
References: <20260930094558.3723766-4-sw@simonwunderlich.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The comments rearranged by this patch don't fully match their
  functions.

--

batman-adv: tt: clarify responsibility for roam flag during removal

The comment about marking a local entry as "roamed" moves out of
batadv_tt_local_remove() and into batadv_tt_local_mark_removed(). That
helper is where BATADV_TT_CLIENT_ROAM is actually set on the entry.
Building the DEL/ROAM event flags in batadv_tt_local_remove() now happens
only inside the branch that queues the pending event.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=10

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 6d8fa6d28fee8..78f032c9ad65c 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -1461,7 +1461,10 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
>  	scoped_guard(spinlock_bh, &common->flags_lock) {
>  		*curr_flags = common->flags;
>  
> -		/* mark the local client as ROAMed */
> +		/* if this global entry addition is due to a roaming, the node
> +		 * has to mark the local entry as "roamed" in order to
> +		 * correctly reroute packets later
> +		 */
>  		if (roaming)
>  			common->flags |= BATADV_TT_CLIENT_ROAM;
>  
> @@ -1532,22 +1535,22 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
>  	if (!tt_local_entry)
>  		return BATADV_NO_FLAGS;
>  
> -	flags = BATADV_TT_CLIENT_DEL;
> -	/* if this global entry addition is due to a roaming, the node has to
> -	 * mark the local entry as "roamed" in order to correctly reroute
> -	 * packets later
> -	 */
> -	if (roaming)
> -		flags |= BATADV_TT_CLIENT_ROAM;
> +	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags)) {
> +		/* queue (roamed) del event which was prepared by
> +		 * batadv_tt_local_mark_removed()
> +		 */
> +		flags = BATADV_TT_CLIENT_DEL;
> +		if (roaming)
> +			flags |= BATADV_TT_CLIENT_ROAM;

[Severity: Low]

This isn't a bug, but is the "prepared by batadv_tt_local_mark_removed()"
wording accurate at this commit?

In this commit, batadv_tt_local_mark_removed() doesn't build any event. It
only saves *curr_flags and sets BATADV_TT_CLIENT_ROAM and
BATADV_TT_CLIENT_PENDING on common->flags. The DEL and ROAM event flags are
built right after this comment and then passed to
batadv_tt_local_set_pending_event().

Two later patches in this series move the DEL event queuing into
batadv_tt_local_mark_removed() and drop this comment. They are "batman-adv:
tt: queue local DEL event under bucket lock" and "batman-adv: tt: queue
local DEL event before marking entry as pending". So the mismatch only
exists at this commit.

The other two points are small wording nits. Both come from code that was
already there before this patch.

The comment moved into batadv_tt_local_mark_removed() starts with "if this
global entry addition is due to a roaming". The helper's kernel-doc
describes @roaming as "true if the deletion is due to a roaming event".

The only caller passing roaming=true is batadv_tt_global_add(), so the
wording is correct in context. Would it read more naturally in terms of
the deletion, to match the kernel-doc?

The ROAM bit added to flags here is already part of the emitted change.
batadv_tt_local_event() does:

	flags = batadv_tt_flags_get(common) | event_flags;

and batadv_tt_local_mark_removed() has already set BATADV_TT_CLIENT_ROAM
on common->flags. The commit message already says this ("The former will
only create similar flags for the roaming event"), so this is just a note.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de

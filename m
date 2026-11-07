Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089421;
	b=x1Hw9JPwpXowerQ1Ua/3BGrRGhYMg9PlVsa6tZJuKJpIpMbBUhbLYNAS1vKaxBGrHpIu
	 lVsqtROL5QSYYehwwiNq4CKIKEjDWHo4vkn58xMbmVfTtR83EQ++PJdTFaagGbDh1ko8x
	 kAEArMQXa16RM/4TTk6Y73M3fbWtSPegZaSSy8miWGllC8zPsMT4PezadwAWxL4pueIxZ
	 d2nZLIosmUMFagkYNJydE9RFpoV30CjHQaANlu3ecdc/JsJukYp47cj7mWf7zy0pGoGTr
	 mFBaiYBqnM6J/zt76ZDTual21waKxF/SD+U9Xj/yw4VIIMoitli1Vn3ZJ1rUX2BWgxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5TJnUxDLYcJHQslxurYixsZ2B8878TTxkxqO4cll/SY=;
	b=Zix+SP2VCmJ4oT7Gy4n0ZG830uNkELbeD+tNg6TRhEaDEAx16N+JdwEdiehNPnZHHFAR
	 TvpmdC5Q/C7j7s5YmHbFl+lcCxNqqCUP3BWiqiBNp8cuRtqNstKRjTgwHZ+WUNpkgLvlt
	 Xwo6vjs3S8QKiZ5GuTtjBGf2ZxVP/+vbWHmuBnyND4z6DqwTpFFaMSEBWLP9j8Yf0Mjxq
	 KSMYRX5DEPj45KpukEauklkx/qpOK3N749JiGheXWTFxAFpuevCoUPTRAfZP9WLS04iVQ
	 EENDPczT2N8SbLLHBmSG1H15pM5VA6SH6H9ynyYdj0jqyWHca63JvMJStOq14w+RnTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=u5AXsq3N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92F606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 22:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A92F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=u5AXsq3N
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a9f9473029so28950b3a.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 14:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794089419; cv=none;
        d=google.com; s=arc-20260327;
        b=raU/WMayhIwDXs3ey9AUAr34Z3qQcBDIWR6LS/9YR7CbsEFpUy2PARq1IAKkYPba2q
         6lZ34gII8rmI6e2AehyofTcrNG/R3KLWOCtd5ljN3AfjNcPu4d/Ez/+Y2tgxzSMPuKQ5
         hGlDqaJYcB/zJtKO7dekLbbtMPw1tnJ29Q61SkpAaeZLdTSvqwfzSifUDyhFzzAOMvQp
         N1rK0ZUTunzCn974SE1c/5eOL2kGXKQ1qLrWW9HRNyL8lwMtHRZRpcpTR2xJiRs3sWJK
         s2Ty11ZXZzNocxKrAJbl9QeNZo0d4eYJCHWMo5CB/8ANaJLQPXbrzv6R3ycBCP3ibZhn
         6Yzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5TJnUxDLYcJHQslxurYixsZ2B8878TTxkxqO4cll/SY=;
        fh=Wb9DVDULmpc6j8VpUw/87dSUm8bUBKa2Tfv3D2tp0ZI=;
        b=CXbRouTdjOYiqlu8krCCS7sdSdDbkbIJgmlaasAMO1Xk9/cP5Em42wFq8xYhDYlOOH
         e3dBV0zAq8cCQhBmpiBpFGMWNtC1zzQu6Bfbcou8NBAtDR1iAQlsOsplXDQxOHvnfH0g
         VfO/ufrWDKwiG8OoB0gibZy9g5AqLIVM8f7CMQ2HR6PsbZC264ZShAf83NzDXOt8hfPG
         tw5JIJ2PEQCyROWHjF9BTArQxQl9vthfFbPcNtwLWsqyC0FtBuYbfQA8gJLwab8lEAFE
         Ug/wTdxJ/J5ifmHeero+H+QxDDctdJgutI3rJElcCbfeI8D5/Mn8za7xNktYjq4031nn
         gnqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794089419; x=1794694219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5TJnUxDLYcJHQslxurYixsZ2B8878TTxkxqO4cll/SY=;
        b=u5AXsq3NwdaS8etlRMSWzvtK031aUlmRv8pu0dgMT5+Efh1ollzsp7TFeWBRW6rnjW
         X3O2Su0QEkod2N7QdFOHaSBMdUFNHZuh/1lX4unJH/HS9yhyvPmcTGO5eEw6odQfkA1N
         nV1iJKAogoCsvLYjZWahRNTAZyEljoXXsFvQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794089419; x=1794694219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5TJnUxDLYcJHQslxurYixsZ2B8878TTxkxqO4cll/SY=;
        b=P1TyuyU8VtsJ2+CkVKxnIRioqGXMHfIpb3xEhhXDCEBGdOyvAJdRVedeqzVYEMcGDx
         d/aaSHwoAmAegTSUGAmoly3lOsQ7VjJ6frLHvIYg67wL8zuC0jT9umElbnyEni/Fk+tw
         3wukfHakhFz0M14rQp3Xma2SzWLgbbN5yjU7BPhaMxRezk9VOGaGYw9pAQR0SbEkHnT9
         yJ1TvlrlGakrH9BrJE4nkHCw2KFosEF+9xw4x5FQSnQFo+8SEosHyELAkcSBVjYNiI0y
         BH2PBy1Ziwvd1gRY84rnekfIXhQjJRSBwcoH4x4ywhMXQrA5AiM8TyL6UvueMoFAfm7H
         K7gg==
X-Gm-Message-State: APuU4Z905IiySICyiLDXEgo37hLm0ld62szyH55FGYbeCnWi3YFhrEaF
	1rO8R+KmEyrhybCdzXVjJGekE0TOwpOeuco7Wzh7PW7KTbPRR9RnWXlP2Z57KCf8VMfLaPLssS5
	vDMp1ZcQDPCwmLfdAODG+4cnI3+cTx8+wRZCuzPeK
X-Gm-Gg: AYBFou0/SVXRBVGyFgpnDt6wC4Z28RjolgAs0/IRLCD2J5OLP9lIGwZUGZF0axW7y1i
	H09jYymaHT7SuWFtPN8dAjskKGKl6m9wd4o9G52DsisuNEuNe0sUSV1cbvgntOPkWPtM2lHMjXi
	ug5X0B763zlXjxHM7FbxkjFbzUm0+ER/XG9+gB8Bf64oNx2DHx/rD4FraQqCkocSZc0cEcHpPN0
	fAFOXxzUsV/clIvVed2HG4MYKmnDB7+epLLZf/aLyauhaDJs+dCFkO15L5ymg58a4jFJptTcWqA
	OEOZbti0KauEkzV79JXSNZwvVJy0uz9uAfh6zhORB/Vh3CMyml37foJls8fVx85UjzcVc1z5m3z
	9X0m88HZa5Po6PK705dFxDfhzm7dKrzs2yaahnIbQKK5qo375yi4gGtaifYCABAtSB9KMPSA9tt
	pm53qOZ/vZikVD9qk=
X-Received: by 2002:a05:6a00:1743:b0:8b1:1410:ac5a with SMTP id
 d2e1a72fcca58-8b66dd622d7mr41092b3a.13.1794089419503; Sat, 07 Nov 2026
 14:10:19 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v3.r0.20261103064310-2@mojatatu.com> <179406301809.994134.18083601714109684155@kernel.org>
In-Reply-To: <179406301809.994134.18083601714109684155@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Nov 2026 17:10:07 -0500
X-Gm-Features: AclHuK_nLFadmgyd0vGCf2IOAjc_uk74qO3Y20nY60ED-Tk07CwICMgFvdp-7CI
Message-ID: <CAM0EoMkwapj0TzbhWPic_JYP8o7L0Hkdppx78PtAq1KoH1Go1w@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] net/sched: act_ife: require a full Ethernet
 header on egress
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 9:50=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit is titled "require a full Ethernet header on
>   egress".

Yeah, that is a bit of an overclaim  - but i will not be resending
just for this. If there are code changes needed in the next patches i
will resend.

> - [Low] The commit message says "A short egress skb is now dropped
>   instead of being encoded." The patch actually drops every egress skb=E2=
=80=A6

Same here. No resend coming.

cheers,
jamal
> --
>
> net/sched: act_ife: require a full Ethernet header on egress
>
> On egress, tcf_ife_is_eth_skb() now requires pskb_may_pull(skb, ETH_HLEN)
> to succeed. Without that check, ife_encode() could copy ETH_HLEN bytes fr=
om
> past the linear data of a short skb. The ingress mac_len check is unchang=
ed.
>
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821164031.=
32824-1-victor%40mojatatu.com
> Link: https://sashiko.dev/#/patchset/20260821164031.32824-1-victor@mojata=
tu.com
> Link: https://lore.kernel.org/netdev/20261022144736.61227-1-shawnq1@163.c=
om/
>
> > diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> > index 6b23a3965121e..5a527da005661 100644
> > --- a/net/sched/act_ife.c
> > +++ b/net/sched/act_ife.c
> > @@ -878,13 +878,16 @@ static int tcf_ife_encode(struct sk_buff *skb, co=
nst struct tc_action *a,
> >   * is an Ethernet header because the skb could've been redirected with=
 mirred
> >   * from a non-Ethernet device.
> >   */
> > -static bool tcf_ife_is_eth_skb(const struct sk_buff *skb)
> > +static bool tcf_ife_is_eth_skb(struct sk_buff *skb)
> >  {
> >       if (skb->dev->type !=3D ARPHRD_ETHER &&
> >           skb->dev->type !=3D ARPHRD_LOOPBACK)
> >               return false;
> >
> > -     return !skb_at_tc_ingress(skb) || skb->mac_len =3D=3D ETH_HLEN;
> > +     if (skb_at_tc_ingress(skb))
> > +             return skb->mac_len =3D=3D ETH_HLEN;
> > +
> > +     return pskb_may_pull(skb, ETH_HLEN);
>
> [Severity: Medium]
> The subject says "require a full Ethernet header on egress". The commit
> message also says tcf_ife_is_eth_skb() "returns true even when the skb ha=
s
> no Ethernet header".
>
> Does the new egress branch check that the skb has an Ethernet header, or
> only that ETH_HLEN bytes are in the linear area?
>
> Take the reproducer setup from the commit message and send an IP packet o=
f
> 14 bytes or more instead of a short one:
>
> tun_get_user() (IFF_TUN)
>     skb_reset_network_header(skb);       /* mac_len is 0 */
> tcf_mirred_to_dev()
>     mac_len =3D at_ingress ? skb->mac_len : skb_network_offset(skb);
>     skb_push_rcsum(skb_to_send, mac_len); /* pushes 0 bytes */
> lo egress: tcf_ife_act()
>     tcf_ife_is_eth_skb()
>         pskb_may_pull(skb, ETH_HLEN)      /* succeeds */
>     tcf_ife_encode()->ife_encode()
>         iethh =3D (struct ethhdr *) skb->data;
>         __skb_push(skb, total_push);
>         memcpy(skb->data, iethh, ETH_HLEN);
>
> At this point skb->data still points at the IP header. The first 14 IP
> header bytes are copied as the inner "original" Ethernet header. They als=
o
> end up in the outer h_dest/h_source unless eth_dst/eth_src are configured=
.
>
> The over-read past the linear data is fixed, and these bytes are packet
> data the sender controls, not kernel memory. This behaviour for L3 skbs o=
f
> 14 bytes or more was already there after commit 5b483f7791b0. Still, a
> non-Ethernet frame can be encoded on egress as if it had an Ethernet
> header, which is what the subject and issue statement say this patch
> prevents.
>
> The comment above the function also still reads as a pure check:
>
>     IFE encapsulates the original Ethernet header and, on decode, expects
>     to find one, so it can only ever work on skbs that carry one.
>
> It does not say that the egress branch only checks linear length, or that
> the call can now pull and so modify the skb.
>
> Should the subject, issue statement and function comment say that egress
> only checks linear length? Or should the egress branch also check that th=
e
> L2 header really is Ethernet?
>
> [Severity: Low]
> The commit message says "A short egress skb is now dropped instead of
> being encoded." Is that the only behaviour change?
>
> tcf_ife_act() calls tcf_ife_is_eth_skb() before choosing between encode
> and decode. So a short egress skb is now dropped even when tcf_ife_encode=
()
> would never have encoded it.
>
> ife_get_sz() returns 0 when no metadata is present. One example is
> ife_check_meta_u32() with no skb->mark and no configured value. In that
> case tcf_ife_encode() returned before touching skb->data:
>
> net/sched/act_ife.c:tcf_ife_encode() {
>     ...
>         if (!metalen) {         /* no metadata to send */
>                 ...
>                 qstats_cpu_overlimit_inc(ife->common.cpu_qstats);
>                 return action;
>         }
>     ...
> }
>
> These sub-ETH_HLEN frames used to pass with the configured action and wer=
e
> counted as overlimits. Now tcf_ife_act() drops them with TC_ACT_SHOT and
> counts them as drops.
>
> Could the commit message mention this change in behaviour and statistics?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/SER-NSBD.v3.r0.20261103064310%40mojatatu.com

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013561;
	b=j6Y8gFKjtC16kFx96TkG8fVgQwp29ta6KxViWiEAf/OXDYXPFrz9xLIfUcCCHxr1AWkq
	 Rhui9EMMOyleBRSJaY85TCEvH5U0P1EiBjyI0udCY8sX8ueqXsEdMyPg9wZgq7iQaig5h
	 WUzSn8QK6aZJiglcQukF4JqAgCfSUMjEWoNhdMHVvycNIvcBkhYE86IWpAiM2ORIzPGWx
	 pE/i9IhF4450XJ18HVlbjnwyo5FeO9yqETRIuhEjq0wNwedM8d+9V4nWzjKrNmRRQFmGb
	 ycq4o0KMw7SazV6KqzwLnOOI455Lkh+s06ZjMMoLe+fZgewNhu/S5eOrMkZOCJ42oGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013561;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=HUBCCmBt2r3pJ9gqCwCptcdEOvWrEL9wpNqjqAAArdI=;
	b=G30OtVktwfiH81J6aPKaefC5bgXNgYw16upr+5ppPC7dCOp9pv5HRqJgi3Xmtz8nzyXZ
	 CmxC2YR/r0t7pMvDOYc1k5eyHQjhFWs7DZqSuSNAUCtVHOqCU8YAizgRxnBBkOgVTzs6d
	 eLXnPmJBSlUU3tQA4MYuMFOZMubOuYhVvreQcyjU+tz0Ok2tvegJhRyJuOKecn90oCxUI
	 EmL0e0UX8FiYygUHPtwwu8ZDxhNZ2npDGqx0vfu/Y9OQva/1Cb3yo/5FpCXH75FZxu+hR
	 03WJ/FKsEj7W6eCabxEldBut5Kqf5mvSVJZD48EnOyCKnUVb94BSMRvsmspOGjRmaaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=exDP8lOG;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=edJhxMFa;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C4606A31E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 362C4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=exDP8lOG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=edJhxMFa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUBCCmBt2r3pJ9gqCwCptcdEOvWrEL9wpNqjqAAArdI=;
	b=exDP8lOGGdvbGxuWcwRBohza8Q5dXzqiTDDeIF4FooZW+etCa8aqRsVG+tamQEgfzSPPAc
	8pAQR2r6VwkiTPpeWP3yMu/b+cqpI2AGPqICjaX0n8Pukd+xE+2KqmTcRRlIFxI2HWSzj7
	qdarzLfP6N6PAN59s5kZs+VuLHERfNk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-IGzplHmaM3a_Z16ZvUvqyg-1; Mon, 26 Oct 2026 07:19:19 -0400
X-MC-Unique: IGzplHmaM3a_Z16ZvUvqyg-1
X-Mimecast-MFC-AGG-ID: IGzplHmaM3a_Z16ZvUvqyg_1793013558
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so2565510f8f.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793013558; x=1793618358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HUBCCmBt2r3pJ9gqCwCptcdEOvWrEL9wpNqjqAAArdI=;
        b=edJhxMFa2df1qMg4OG5AjcrSprOPCmo3n+yHEG+41QeLu7FHZ2+/SpTfVpttmTHcaO
         Ql3mMV2REfFTRVTQdudtzslARWrXYNk7LOgEc6Di0qj49GNY8W+7kldqP1CKacCMGx79
         v2LORWjgX/JMS+2KvfNRClAzsYLKaAgU/t4CWHW9UIQHyyIvW9n2vOJlgO+XRrD+gPCw
         fr90RBjRnTa0xsnD8m7zX6+6GsiGBFCRZB5BG8NCXBnT9evusgLlWlF5i9ItQfLac+2S
         ZbNeBaiPq4A4Q5Hsc1HFhVpEjPpNBhM5hrE3YP95ewoykkSWdcEoBBYltM++/5aXzO12
         s3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013558; x=1793618358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HUBCCmBt2r3pJ9gqCwCptcdEOvWrEL9wpNqjqAAArdI=;
        b=mLCgXzWPjnHg7lqeVlk/a3PZCj/rM0cKh5fLZnPOxudRVztfm52XMtVnJdb857ygU+
         rVzwn08ypt3oXYMT3CnJrpNQeMQBDZfDxCg3joL3TWy3hZ1bWpP+EGASL1aqt4+CnCvy
         Sc1M2p7TSjQ9ihCFXHGPBuLSrJqpTPn2NHh72mEByB47Khvu1YIqXrJADtl2/DPBcVAZ
         pxnwNdFASuOfpoP3nJlQ111Crlt89zKTW0SAXjf66D1ZXGvgqx166kE0uDGge3+t76NS
         SJScn4eVP2Exz38x1laJTXkr0Jeg2Z445Lnods3WT1BYExFoIuYrh0aZxUQO2yiCfnDv
         FrTw==
X-Forwarded-Encrypted: i=1; AKwUvBy9T+OeJ+67q2sSrIgxr3VrBfxKpaX+QB0un7ConeCiYY13wpDMuaDYmv7y84AFO9jPSaQeFo0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEbzmlITiv5jzTEufkB1HXr2mAhSd2+tCKMilMYdtKUcV9RKuM
	DAKwRxbNfVh62a0YUgbV0Uejw98pXXjcmecTKdCDzOXbL2PDquyBnrmpKXnGaEmuMBW8MydAqam
	UVcsMxtEpOTwi7Zr3YNDteM6Hb0Z/TYiOZNlK75xuoW6J5Ai1uaXtuKGPIg==
X-Gm-Gg: AYBFou3AGK2DqNpTwlK9QsUic1kdrsoNrbqVCH8HRKifRSjp7dsnbqSmdhSsqt6jfmJ
	oJX3g7w2BMfS8SVcvd7voKjsXU7yo8R0xZssoX4UUckmka+1zvJKySFjP+q/cFc9zG7c294cBWM
	ptpSnpg+3E/qx/FJxaLCNmZh6jUrCgU5/Z8DeYPRMIacQV3UHN3I4kyfF5I1AuqC5C+75OoCNih
	50/VVQqCX+K4gVK3sJWb8WTXKKOGT59PLkl6A5qn0D74fDhY8BnAnW9edHQFCl7zXWkjOa1HNNj
	3U8Bo0Opyf33q2lPW/dS5O5Bk25kyxByJ5CBhkfB56/f4tt8UWpJJamNGiqXq8WsnWkSVELQTmQ
	66d6RbIrc1d/T5z17BXTyhqcys+dBnZhAFcmvnlTNFxRVbA/369cBmQ==
X-Received: by 2002:a5d:5d86:0:b0:48d:f996:1814 with SMTP id ffacd0b85a97d-48e3eb9c7fdmr10996894f8f.57.1793013557040;
        Mon, 26 Oct 2026 04:19:17 -0700 (PDT)
X-Received: by 2002:a5d:5d86:0:b0:48d:f996:1814 with SMTP id ffacd0b85a97d-48e3eb9c7fdmr10996782f8f.57.1793013556171;
        Mon, 26 Oct 2026 04:19:16 -0700 (PDT)
Received: from debian (2a01cb0580324c0086a938fffe1eee25.ipv6.abo.wanadoo.fr. [2a01:cb05:8032:4c00:86a9:38ff:fe1e:ee25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm17193489f8f.32.2026.10.26.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:19:15 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:19:13 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Guikun Yang <yangguikun19@qq.com>
Cc: James Chapman <jchapman@katalix.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] l2tp: OOB read in l2tp_recv_common() for L2TPv2 sessions
 with 8-byte peer cookie
Message-ID: <at83MWsp98Mei-Si@debian>
References: <tencent_389453EACB37DA0886D3896959D4A4CF5006@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_389453EACB37DA0886D3896959D4A4CF5006@qq.com>

On Mon, Oct 26, 2026 at 01:35:25AM +0800, Guikun Yang wrote:
> Hi Guillaume,

Hi Guikun,

> l2tp_recv_common() (net/l2tp/l2tp_core.c) reads L2TPv2 optional header
> fields beyond the linear area guaranteed by the caller, for sessions
> configured with an 8-byte peer cookie.

Cookies are an L2TPv3 feature (RFC 3931). They don't exist in L2TPv2
(RFC 2661) and l2tp_nl_cmd_session_create() ignores L2TP_ATTR_PEER_COOKIE
when creating L2TPv2 sessions. Have you found a way to get a non-null
->peer_cookie_len on an L2TPv2 session?

> The UDP entry path only guarantees the first L2TP_HDR_SIZE_MAX (14)
> bytes:
> 
> 	if (!pskb_may_pull(skb, L2TP_HDR_SIZE_MAX))
> 		goto pass;
> 
> 	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length);
> 
> Inside l2tp_recv_common(), for a L2TPv2 session with peer_cookie_len =
> 8, the cookie check consumes bytes [6, 14):
> 
> 	if (session->peer_cookie_len > 0) {
> 		if (memcmp(ptr, &session->peer_cookie[0],
> 			   session->peer_cookie_len)) { ... discard }
> 		ptr += session->peer_cookie_len;    /* ptr = optr + 14 */
> 	}
> 
> Then the sequence-number branch for L2TPv2 reads at ptr:
> 
> 	if (hdrflags & L2TP_HDRFLAG_S) {
> 		L2TP_SKB_CB(skb)->ns = ntohs(*(__be16 *)ptr);   /* [14, 16) OOB */
> 		ptr += 2;
> 		ptr += 2;
> 	}
> 
> With a minimal 14-byte L2TPv2 packet (6-byte fixed header + 8-byte
> cookie, no payload, L2TP_HDRFLAG_S set), skb->len is exactly 14 after
> __skb_pull(udphdr), so the read at [14, 16) is past the end of the
> linear area — a 2-byte slab-out-of-bounds read (KASAN catchable).  The
> subsequent `ptr += 2 + offset` handling for L2TP_HDRFLAG_O can read
> even further out ([18, 20) with the same setup).
> 
> Trigger conditions:
>   - an L2TPv2 session with peer_cookie_len == 8 (admin-configured),
>   - a UDP packet whose L2TP payload is exactly 14 bytes, with
>     L2TP_HDRFLAG_S set and the correct cookie.
> 
> The peer address is not verified on the UDP path (l2tp_v2_session_get()
> matches only on tunnel_id/session_id), so any host that knows the
> cookie — i.e. a peer of the tunnel, or anyone when no cookie is
> configured (in which case the OOB read does not trigger, since the
> pointer stays at 6 and the seq read lands at [6, 10)) — can send such a
> packet.
> 
> This is the L2TPv2 counterpart of the L2TPv3 optional-fields OOB fixed
> in 2019 by commit 4522a70db7aa ("l2tp: fix reading optional fields of
> L2TPv3"), which added l2tp_v3_ensure_opt_in_linear().  The commit
> message of that fix explicitly noted that fixing L2TPv2 as well would
> require refactoring l2tp_recv_common() and was deferred:
> 
> 	To fix both L2TPv3 and L2TPv2, we'd better refactor
> 	l2tp_recv_common. It's complicated to do so.
> 
> L2TPv2 has remained unprotected since.  The in-function
> pskb_may_pull(skb, offset) at the end of l2tp_recv_common() runs only
> after all the header reads have already happened, so it cannot help.
> 
> A minimal fix for the v2 path could ensure the header is fully linear
> before parsing — e.g. in l2tp_udp_encap_recv(), after determining
> version == L2TP_HDR_VER_2 and before calling l2tp_recv_common():
> 
> 	if (session->tunnel->version == L2TP_HDR_VER_2 &&
> 	    !pskb_may_pull(skb, 6 + session->peer_cookie_len +
> 			      (hdrflags & L2TP_HDRFLAG_S ? 4 : 0)))
> 		goto invalid;
> 
> (or a full refactor pulling the cookie/seq handling into a
> l2tp_v2_ensure_opt_in_linear() helper mirroring the v3 one).

I personally think that a full refactor should first stop mixing L2TPv2
and L2TPv3 in the same code paths. Although these protocols share
similar concepts, they actually don't have much in common from a
technical point of view (different headers, features, transports, etc.).

Starting packet processing with a pskb_may_pull() over actual header
length would make sense but, for L2TPv2, that lenght should be computed
based on L2TPv2 header flags (the Length, Sequence and Offset bits) plus
the Offset Size field if the O bit is set. The ->peer_cookie_len field
should never be considered for L2TPv2.

> Checked against 7.3.0-rc7 and linux-next (2026-10-24): neither carries a
> fix; l2tp_v3_ensure_opt_in_linear() is still v3-only.  I found no
> report of this specific OOB on lore/marc.
> 
> Best,
> Guikun Yang
> 
> 


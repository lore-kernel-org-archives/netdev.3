Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021427;
	b=yOyC3A3hsdmwKVGvGEcNdOgKhdu/8iEu4s152KX4DLJIZSF2HB7cp3205qSI1S4C7xkW
	 xrWNTlX2WZIxez8+YyFsnUIbfi3uE1GRQARjtAKONMqFzZQFTEjOQ2R5HtFJHBe64PI5i
	 pFDKuIgo1KJHPWThtFb9kbbXdMdntCIvegaGp1PdzvI9tZD2ayiAXkD+MUG9uz+FTHwDj
	 6laDoQMC6+/evcKE9LVBW3HysYtVk2xe89oHlnZTrxmmQErN1G+4v6XDfLZzbAGYhr8Q0
	 vL6c29ykFdYzT0wP+OyWne+6PR+InntzxZRFb059pvnin5qwU8eiU1UygC0DDdQ1SPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:
	 In-Reply-To:References:From:Date:Subject;
	bh=/Af3dxVFdK7w3VK33AvL8Uz9Ngj8vYoQi7CthafUnO8=;
	b=R5IMetED0C9GGpnEva58wf3pG422Wgpk/AdhrZysmGhRdECSTMa5Q3OdJ/XiMvrpjhDY
	 frnH/5V+I+qV85XEEuo1AiQc9nr386mybpiMQB92mozyFPFvuBYhbBn16u8cKj/cShSsN
	 xz1cZ1oXNuHIWIrgzAeeIjnqm3YuxTSAlG4+ZXnIeDZ78/eNtAxrPXp6AMIc91kOh3UbE
	 akv3UQYg9Ler4MRlYEHaE2ZaQKRD+pGdv0DbXdQyDQQ+n6+CmCewvm4pvWPRIJcBvYTiC
	 TzB6f9yKkjt96i7PZ/05a6Mur/gQMBBF0jKB4L4GfBfZHTAOMmAxcuBrIu+RsxWx5bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R2F78KU+;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA17606A32E
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA17606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R2F78KU+
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36d1b3b9974so123825eec.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794021426; x=1794626226; darn=vger.kernel.org;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Af3dxVFdK7w3VK33AvL8Uz9Ngj8vYoQi7CthafUnO8=;
        b=R2F78KU+hwt4XFx+iD0zKLcnZ/xdcab1mfmsBmOazJa98Tk4RaPzcTauct2pXc0wMy
         iqocWQpPTvhsIO0QfKHUAPjmgYU0P0Umxzel9TQIpxDo1+GRLF8anZwzmSC//seEfohr
         SXTJmzGk7Ap1VmOwIEmTVKKfZQxx1oCUcIGbQdHYzGunMJVHA4JZs//pcfFph3Fe3BF9
         Lh74clv/GMTafJE5HSdOJOwcEGfyBTyS6HuJQHCs19h7Un0WCRYMPFCiEX960CQrNX/H
         +SiQumXn0l1ugqvrFmFBO0Nyo14KCPCVEq8N2qo4MBpvQ0NcTqZLtGOD5MHTXI/ggYJl
         O+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794021426; x=1794626226;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Af3dxVFdK7w3VK33AvL8Uz9Ngj8vYoQi7CthafUnO8=;
        b=He1SEMyK/T7EDrWNbED8C69yiQX2U5qPR4aQbMUc54vwOPVu613PTzHDsj94y605e6
         GdvGTVi2pjtrtmKiqcbPGDMu/OU78V4wphoBhZsImsIIRlKzb70p1uEe1mwpZjeBYw59
         0xU5449WUFYFZAq+nSmvbAzCoPpMGBhxkyBd6tap5vO2hl2bVXwc6McwkVtpSykDgRwA
         oIjkF90KbtsOn9ncX7sR0ws8LdB0t9/czpy2fZKHQd+M827XOXcelq42Bi+1BC0MmUgB
         /5n5r2kUhrKB7Nu9NoCsFhDShR7rgWws0mw6o9iVpc/qTsAG3P7i/IIvgEA5WHqVTFRH
         r9zg==
X-Gm-Message-State: APuU4Z8Sf2cpmCOMb973MjUu9LFzFaej+J3dyeq073BpRfNU6eCWwF2P
	Dx1HpJn9st4xKmRUi6f6YSEORGyjqQ+dM2xvIawryng02HnQoI44dbph
X-Gm-Gg: AYBFou3v2uT38pC7uQnWk+swlU8/JCG9uQXU9mvZ1pQNSprYi/5kFc4hhfcs5/KobyX
	fmr4b6MmdTQbdNJOfN2o6UYtJieKHV9Ia70XPkTi8o9Uh7eWpon6knnMheVWKFY6ZXgU76H7ozi
	eVaa8pX//NtPHqU06l+FWMW+29jEJc23R+fHRNaJvLiIGRmzALCKIzMkpmEMFb30vzzZEJO+aT/
	7RB3jEpkNM9zaZfdOJ5IukKWvxTR6/lXFPPYamOHWoMXgjeco89MWnnbYNF1XQIEs5NHAspS8Op
	Rd8re0x21ymiuIWuz0EWAe4btzgegQdkDFKGbvDsH10IotCodRXr5FBIKM/WzQ5bU3UPjqlPmM3
	QR74LeeTi2podA4/bgMCoWXX/sudSYVb/UUOPSu2uYRKKVQioiw9DG8OCirXTSO8bY5Trguu+Dr
	oIn2q+0efY3oNeJOiZVOo04ANErNiWCmfOHyswseLK08l0ElWruIbekGcG4qb6OM8dcaWFX7eXj
	jGeqIo2gyIfwW/yWNOUnLmcXzAl3O6+YYHQC0hi1lyhG3boF5FysEKIoHiw12y3f3iyOsSLh5Nx
	YN2axyWGHhGhkg4WCQlldwpUithNHehqrUSmdi3gWW18KVXY33KjYs7bjWkQ0tssl81FlPaQFIN
	Arqyn4RJNXRY7XtOI
X-Received: by 2002:a05:7301:5156:b0:35e:d21c:f33e with SMTP id 5a478bee46e88-36f7474bfcdmr9771823eec.1.1794021426141;
        Fri, 06 Nov 2026 19:17:06 -0800 (PST)
Received: from msg ([188.253.120.78])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4c1df6sm10235540c88.14.2026.11.06.19.17.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:17:05 -0800 (PST)
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Message-ID: <20261107111617.21347-3-q.h.hack.winter@gmail.com>
In-Reply-To: <20261107111617.21347-1-q.h.hack.winter@gmail.com>
References: <20261107111617.21347-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Sat, 31 Oct 2026 10:07:03 +0800
Subject: [PATCH net v8 2/3] xfrm: iptfs: hand the drop timer back to the
 reorder window
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

__iptfs_reassem_done() cancels the drop timer whenever an in-progress
packet finishes reassembly, even if the reorder window still holds
out-of-order packets.  Those packets were saved with a drop time of their
own and the same timer is what ages them out.

If the missing packet never arrives, the window is never drained: the
queued packets are not delivered, and each one keeps the xfrm_state
reference it took from its secpath, so the state cannot be destroyed.
Nothing re-arms the timer to clean that up.  iptfs_set_window_drop_times()
only starts it when the walk back through the window reaches the empty
slot 0, and an occupied slot 0 stops the walk.

Cancel the timer as before and, if the window has entries, arm it again
for the drop time of slot 0.  Leaving the queued timer in place instead
would keep the expiry of the reassembly that just finished, which is
earlier than the window's own deadline; a reassembly started in between
would then not arm its timer and could be dropped before its budget ran
out.  Arming it for slot 0 keeps what iptfs_drop_timer() expects, one
deadline that belongs to the window.

Fixes: 6be02e3e4f376 ("xfrm: iptfs: handle reordering of received packets")
Reported-by: Lilly Aronleigh <lilly@aronleigh.au>
Link: https://lore.kernel.org/netdev/20260824072851.301644-3-lilly@aronleigh.au/
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 0313a43aa..5ea3e77dd 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -708,6 +708,15 @@ static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
 
 	/* We don't care if it works locking takes care of things */
 	hrtimer_try_to_cancel(&xtfs->drop_timer);
+	/* The timer also ages out the reorder window, if it has any entries. */
+	if (xtfs->w_savedlen) {
+		time64_t now = ktime_get_raw_fast_ns();
+
+		hrtimer_start(&xtfs->drop_timer,
+			      xtfs->w_saved[0].drop_time - now,
+			      IPTFS_HRTIMER_MODE);
+	}
+
 	if (free)
 		kfree_skb(xtfs->ra_newskb);
 	xtfs->ra_newskb = NULL;
-- 
2.54.0 (Apple Git-157)



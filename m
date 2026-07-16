Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5A3D410D
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200986; cv=pass; b=C+p+x6CsczcxYvQBZN4TRnkdmAhE7CrrGz+j61IYqiGw9feGpl4W9CousKAauDVHhOVSUeABzdBUYaKGCJ2VPV+GsPLvrDHkdSEFDxPyla2hXtH1MYX8EhMu047f4kRC8ylzQQ+mZUDFnFwr0FmDnJe73xnubWmeu2QQbG4uXV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200986; c=relaxed/simple;
	bh=oYH+zCykP3nxD+dABR4pixhBxWPbhrc9AVW3gh7xOi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGAvQ2M4JPr+Skw85f000GJB6+5sEIPHesVS/+vwOyC29bvH63k9C5IRBhkG+QNoeOQQzq1hG/mkXQRFhgo2LVbmmUZ51EGOELzhtaLwV7pajoNp8nos4WoLUhek4B220id39NzChh+AGTQYk/ul+KSo+rgTg59RcHs70VZW3CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMK/DjKM; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMK/DjKM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so75075955ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784200984; cv=none;
        d=google.com; s=arc-20260327;
        b=I0+0O36T2X6tLdK3UYZslGSXqKyPE3t1c7yYdQWDNtB7T4ZR+JAFsk/4de4y1bDC/1
         1GXTnm6yLQNjUH/48H6bqMH3aJ+O+kmP0wZaa4FLIFUXIr+yfhXuPSNZIuPnEYdVJoIs
         4ip4WhBPkyHJBow4s9wBkgJhA0YIGepFniEnzAX72EiNHIFWhghEsbhtgygtmMohSy8Q
         493k6P1YQbOaPwCjBkzkfOfQN+sEcmuZxKhpzRDrW0xiU08JOvVhDHmvWO8DMCATzEZC
         vfmnzWmqNV8A1Q836VNGsMYHf9KGPpg9A4Uyy0Lel9aWS9SeXawH74NtLENHt3rd712B
         3dQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbRrcnov8km991My2tmYBPDRYU7T4Dy2j7rkUM4ZkWo=;
        fh=iQyfmahMB3C/1k5ZOqTpS1ZCAShbyOWo1k7gUDQ9Q6o=;
        b=EYb3b/JFm0C9djMEPf374oW/t2+3o5Rnb9pN0/j3xVMmzKubeSxsf028L0Nm4r3kfc
         GhNOcEdzhl/UgRU+B0Vygi8ZTxaRxqnHQnh74m0NqUmJQpbdKdDuaYj+cgi8JPcA1VJz
         IqQfiQYrYOHQNR4Cu4XENQh1GxU8sP48qn49Ri+VrxuRmV056U2vOn9JCxTOyq4iP5/P
         Sc5UIgPRWrTBLxeWOm/xvN+HcpWtPMq07zTBdxURvFv7ksY9x9jsTgWvd+zuqixprXwz
         JDml6Hv6dCFQKLos4uw5A6eLqUc1ohuRARwgVkdcOWcixxsIRChf87h+yJSYkLOW7mlY
         bMBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784200984; x=1784805784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bbRrcnov8km991My2tmYBPDRYU7T4Dy2j7rkUM4ZkWo=;
        b=qMK/DjKMBAQMAfvWlS4z7kSfmd3mkSWCFVreY3MyVWlLsBv9TkG+nHTqT/m55aNTWa
         3d12mpAb0ToCmlMxALLYr82NYP2WW+7CnBNdUbhpenF8pf0KV2qSbHWikY7zX9O0OIi3
         88pTVkXvswicG+ixEnAEgdAV3GuM9adrV8ymq+lZAtCbBHgH/Uzl5EWEQ1DhoBNiQROn
         keYFmqKiNv0SlAEIRHrZ7ugMEKR+9HM1Fwn4u6p3ir02jpiQWV6fEklnN+MXk55xHdno
         7ukWW29lLW9iEBmJYwYiMBaXkrifpiiN3klYI4aOsmHomOxQIZKlOUcGB2i4dEKw6+XO
         S+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784200984; x=1784805784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbRrcnov8km991My2tmYBPDRYU7T4Dy2j7rkUM4ZkWo=;
        b=kZ/4IIJ/jebFQqtMkBZUrR+KlquXPL9rTPpvNAG3MmWb16rddvpHD8GavRfwlAipxz
         1PFMSLyWmBhYzIyvM4JRUUYq83blvoKg45XrvQql605SOkOZVxJ6ABydF50vAbccnUnO
         aSeZQT/hg6havx12xVJm+Z0WXaMFFLUPGKX35JBGkqZD3jfOzhY6QBAHlH971jxQtbk3
         NNL7czRF217V5ZUikL0TtPSje9qUrXZmCSOanrBgmyZAtXNOPpE9YU5geWJsApIi+zqm
         Lm/8ygINhroh8vIEOg6l1jJ9V/QTzDmksvc/SjE70I24Hyvp4I2MxjJ1uoTkUrYSTGWY
         Tb+w==
X-Gm-Message-State: AOJu0YzVg4nN+3qZoT9++W6SO5ugi+7No9YCvMVgcAclVEdgxXb7QsSc
	heKn8nHY0Y4Pq908SzxALzMjCj4Mk2wT0DCaSvRqryB4LJQLG+JeUO8Eek4tAMUtwgZYyLu58Ur
	WCkidWcVqD7xKdUbx/MqGd/1y3+r+mq4=
X-Gm-Gg: AfdE7cmwQLP7nal+Dzj8GgjCuCepyYHndWjt2TgA7OaK3fGSoF0CxMQKyQLwwETbTHg
	FNxkYADi4H7bEbuYtUlPlKkr6KgsVysKsuNJTEG5bhzmLcEXAdExr2ZCAWiOPKWoYaBKGpWaejn
	6c7ESK2dITmABq48ETDkW/vRA5+9pkvtKZeej44lJcxy1pFajn4Gtaf7QimQ0zMAyqikFsncV8w
	LNuykdxYG9N2C46QLyUyjUCsagH+6U28XaomnAF5VkQi26Ns56/zeVdqV6EoEa2bKsZ6Lc/Ql+D
	JIcGczhFyAe6UW1eGULjAuijHHyFBOiwvHdYit7kMHSq+TDrHSgpttpCwHQMgz1gPGBgXLjnTTY
	aOnupAR0HPw0Y
X-Received: by 2002:a05:6a21:101:b0:3c3:9b44:982d with SMTP id
 adf61e73a8af0-3c39b44f10dmr569369637.42.1784200984341; Thu, 16 Jul 2026
 04:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com> <20260714140722.111645-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20260714140722.111645-2-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 13:22:24 +0200
X-Gm-Features: AUfX_mxz84KquZjL3HAxXADNfyK7IXrd8-N61IqEcDyytdV68gZc2xvlnpmcRes
Message-ID: <CAL+tcoAc7d8MSCqK23_pmL2G8tSS-MpfM53brijPntv5A+BA2Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/6] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> This patch is inspired by the check[1] from sashiko. It says when
> overflow happens, the address of cq to be published is invalid.
> Actually the severer thing is the whole process of publishing the
> address of cq in this particular case is not right: it should truely
> publish the address and advance the cached_prod in cq as long as it
> reads descriptors from txq.
>
> The following is the full analysis.
> xsk_drop_skb() is called in three places, which all discard a partially
> built multi-buffer skb:
> 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
> 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
>    the TX ring prevents the partial packet from completing
> 3) xsk_release(): socket close while xs->skb holds an incomplete packet
>
> In all three cases, the TX descriptors for the already-processed frags
> have been consumed from the TX ring (xskq_cons_release), and CQ slots
> have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> the buffer addresses never appear in the completion queue, userspace
> permanently loses track of these buffers.
>
> Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
> destructor, which already submits buffer addresses to the CQ via
> xsk_cq_submit_addr_locked().
>
> Note that cancelling the descriptors back to the TX ring (via
> xskq_cons_cancel_n) is not a appropriate option because an oversized
> packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
> which is an obviously deadlock bug in the TX path.
>
> Also move the desc->addr assignment in xsk_build_skb() above the
> overflow check so that the current descriptor's address is recorded
> before a potential -EOVERFLOW jump to free_err, consistent with the
> zerocopy path in xsk_build_skb_zerocopy().
>
> [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.o=
rg/
>
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path=
")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Maciej, maybe your tag is missing here?

Thanks,
Jason

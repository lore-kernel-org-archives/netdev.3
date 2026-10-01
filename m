Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AFE35C1AD
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876748; cv=pass; b=jqeBaKsiqf8A6pGrdntmZHfguoLGRGp3nrDVTSYHJq9m8tmVFaGvb0W0rPek6MDkP7owbXB64FqmFW+vBl2HD+9mqb2yp5gxDqApMhOLhiHRb2PAMGt1WpRFl+pa49xSY30Dv8RozyMX0wfXOR3kdX7/14qU3uYkC5Au+lj9VDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876748; c=relaxed/simple;
	bh=DVS+yU4MeXSTJA0MnoG2/WnDRMIiZcABsJSeQLqj3C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SP+25KoEx9bPlJrxPwFfoLnPKLGTdHq5fk03SbhIpfoFLf1jGTpV/CPlmPN22jRDBov0myuSuliQf2z0DAP8xmPbRi8CsvxPR5YwkwGu0Uc3nc3ZS5Be5PifHEVX3GEz5GqWd9UAitxVO+K8uHLodeElnssnzz7poIxkhIEvvec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciqmt8S4; arc=pass smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciqmt8S4"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14e1fe551c3so911627c88.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 10:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790876738; cv=none;
        d=google.com; s=arc-20260327;
        b=KKaDqSFPQqOHSDa8QsylILQg4Zu5NEMQKApGRW1YOmxlngkInIETUJ4w1rRCdK0wAS
         Push/5GPoZ2SLaQPJyA3nepY093Uy6rspPQfCarErDReWIfxdBdBzYembwU4QIPz+owQ
         Qfs6wgObbUcra8DGMzRG2As6oH6K3bl6n6Vts238AEmJtlHTWrHnFEF607LXPRnsiKvj
         dPKA1SJGJurShyHV0tMJErWHC2Iq01hVmNPe7156VQ+eeICZwE8zTO4XTb92if7PVeof
         NLchwPP6sGBZLO8OGGPNIIsYL9OYX2S0Rfd+GCkPqY9aOV9tm8YeFQn2wpeAii15jZXQ
         +ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kd+gDsb79tDRiS43i4aFe0o9+muNoh8xdfZbWxrNkr4=;
        fh=rjNPBnFaUABckl+aDQiFztQ+BTeGjOgM61XY3OTTZZE=;
        b=N/p/HbNNd4zX6EjqNI9+/sLOVoWVxgKk+WieTmi/nu2q9g76/EFoUGQN+aCmR2FBfn
         vcqH0MmtsG0ZkQdXl9BBBeD5U1hEn0RyIHg8uaO0LRcAksgg3XESvBreIXUFbC3+eUDc
         cb4gLWZJ4uJaSStx5jLcQuawCIm3fl8Jy2cJ6ZcW7cQjx7s7mG+0e6rcm3bGR7GuulzV
         OcdNP+A2EcgMDimBdj0NPTWyPCbo/1eofA76/nEfGg8qQDuCRaJhSUZydd4M5VJXrjEp
         lD4MOsMkNWZtrvB/fT3vj6om2g+R8dN+pBX9h7ZBpaupEicWZlXAgrNA5CwhYUugELAy
         E/QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790876738; x=1791481538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kd+gDsb79tDRiS43i4aFe0o9+muNoh8xdfZbWxrNkr4=;
        b=ciqmt8S4Fpo3CZZhLA6ke2yHP927Xi3sw4jc1A8EQX7LF++Y+gano7z0pCcpqZsxAo
         sNEx9QyaE1q0+rWD2NugcJ95OHAE/2/GyVEJYY/okfdw5FLcwLT0pQRWio59L5k1NT57
         8cnzqyge7AG8UcWf1zH8PjEtkdRevERRuG3rt0xH/mPAyOv++dOIalBlUaToEq48/9F6
         7Ry1wJNd+nXZaV/Ue3+feW8ppbuwtjTVkK2utfCfl8SE4wzGum4JVUbNi6EnXEUMocKp
         nH3Hsh4MrcQXg/9gYLba/HL0zNccxmrqr9qFKHvqvOF0PAXmJnbO7xcYFj8RaGxbqHxB
         dNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790876738; x=1791481538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kd+gDsb79tDRiS43i4aFe0o9+muNoh8xdfZbWxrNkr4=;
        b=NZoQGL5mg/Z54UXVeTeR4WDzMli1cgLp3Kd70i1lm+V4Qf8IltuMZc5k2Q035Lvd6M
         qQhFPrvIfPlSYLYC/phktWbNvRAD/elEW/d7vKh3Gyt/qakdiw/b0d/WdHVXZUZvvNTW
         zd8w5iZmynZDxV8rUPXFAuRK6dXH4worBs4VlanTWhTYoC89WHNA/HkE5ePXSOUvwdkW
         /XlDoGbwcswU+6cni3YXMuROqN4oG+E1DRSdCSXZKmBfgLO6nPTMmD64qDo2TdM7Gn79
         raYRimCtaCwJOd9RA0VEHiELzFs8oJsLkNMt29xjtsy+1hFz7ZQFB9ztm8Pp2UMnobXq
         zENw==
X-Forwarded-Encrypted: i=1; AKwUvByjvku9iM55yz5ESQPA+oA2Wqix1k1Qa3GcciNWPOqpo7nqKFAjnbcqW71/7PuGfY02RhE5w1s=@vger.kernel.org
X-Gm-Message-State: AFuF++kcg9KGIaYY3BnylyS9Q5sDBPSgm3Lmz6ckfvl9YRZSz7I43FPw
	+PhIgaJaDRkyB10M3v92c0D+FJ1WMe3+skl6SelbsMK3xD/vgQV94nAhZBEKI+vZNHZIY0YG1hT
	FGTG6XRYDZeRXNwN8Khfy2Bb3cjL41Y2r7bc4Hqkg
X-Gm-Gg: AYBFou37kGbtwsBK5e8Xf8fQPtmYDjd6jUWzKT3vigmxKh5fh8drxUXhm8ZzBXIQ4Rp
	jhtqi1EivZ9RJKvY3KY1HrV86n9uXlkt8o2t26NXCqhkgBb0fPHrAetHGjknPi/4kCeCqLJ3iMK
	mibOY/NFp6jGFKZjj6ApG5E3Ob8TBElo5aV7zdAsOg84nI6bp3HiRU3LxgHN7GO8ruE17x6ZCiH
	pBvAvN1fST0Pmb9AbOFQi0ImJQRjBuRsmcmE5xwcjrs+jkeihiWQMEWjDC6Hh55M5/XknldPk75
	qmGz6u4mA9X9t4xf+P58QAvkYWDc+h5koJVB3lZlodXnDNGiItZ9LXNbtJONXsfPr7+htxcpsvD
	wBbou6CRD+iFOURid5YDIC3mQFCOiyXi+DUUbO9ARmKAZhGLrAjQu2OHwg+jAr/kAUqohMJKE9t
	1/8W+kM0WNzOlem/REkAKNPoE8
X-Received: by 2002:a05:7022:fe09:b0:144:eb46:be0 with SMTP id
 a92af1059eb24-14d31c6d959mr7036975c88.13.1790876735713; Thu, 01 Oct 2026
 10:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001143040.28467-1-parri.andrea@gmail.com>
In-Reply-To: <20261001143040.28467-1-parri.andrea@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 1 Oct 2026 10:45:22 -0700
X-Gm-Features: AclHuK_PRj6kNhTkNAge75mh0uRy0R-jClYZQl-fhXQ_Zc5OUMVS0wPKh2mqOHc
Message-ID: <CAAVpQUCPBAoofDeDMdQii=5P6FyRnKOdN932fTuocHtb4H+m1g@mail.gmail.com>
Subject: Re: [PATCH net v2] rtnetlink: wait for RCU readers in rtnl_link_unregister()
To: Andrea Parri <parri.andrea@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 7:30=E2=80=AFAM Andrea Parri <parri.andrea@gmail.com=
> wrote:
>
> rtnl_link_ops_get() finds ops on link_ops under rcu_read_lock() and only
> then takes ops->srcu. rtnl_link_unregister() unlinks ops, then calls
> synchronize_srcu() and cleanup_srcu_struct() without first waiting for
> RCU readers. A reader that found ops before list_del_rcu() and has not ye=
t
> taken ops->srcu is not waited for.
>
> Such a reader then locks a cleaned-up srcu_struct and keeps using ops
> after the module that owns it is gone. rtnl_newlink() and
> rtnl_dump_ifinfo() both look up ops without RTNL, the latter for any
> user that dumps links filtered by kind.
>
> With delays added between the lookup and srcu_read_lock() in
> rtnl_link_ops_get(), and before rtnl_link_ops_put() in
> rtnl_dump_ifinfo(), running "ip link show type dummy" alongside
> "rmmod dummy" on a KASAN kernel gives:
>
>   BUG: KASAN: vmalloc-out-of-bounds in __srcu_read_unlock+0x57/0x70
>   Read of size 8 at addr ffffffffc02ff318 by task ip/147
>   Call Trace:
>    __srcu_read_unlock+0x57/0x70
>    rtnl_dump_ifinfo.cold+0x30/0x3b
>    rtnl_dumpit+0x7a/0x1b0
>    netlink_dump+0x486/0x11b0
>    __netlink_dump_start+0x661/0x910
>    rtnetlink_rcv_msg+0x611/0x9e0
>    netlink_rcv_skb+0x126/0x380
>    netlink_unicast+0x605/0x830
>    netlink_sendmsg+0x6d0/0xbb0
>    __sys_sendto+0x335/0x3a0
>
> Call synchronize_rcu() before synchronize_srcu(), as
> rtnl_af_unregister() already does. This should be enough because
> rtnl_link_ops_get() is the only RCU walker of link_ops, and it takes
> ops->srcu before rcu_read_unlock(), so every reader that found ops is
> covered by synchronize_srcu() once the RCU grace period ends. The extra
> grace period only costs time at module unload.
>
> Readers and the writer were serialized by RTNL until link_ops got its
> own mutex, which is why the missing RCU wait did not matter before.
>
> Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks

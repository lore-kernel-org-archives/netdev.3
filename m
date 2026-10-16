Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B58339375
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116484; cv=pass; b=GZ6oBK/r6QwBevZ74N24pN2Avz0/MGyjEjQgsa+r4NuK/3LmLbn99sqcxMiJTsKH8T9AvRfWfK5a/TnBroi2chMfQa/3TUYwH6NxRaMVh/ZOYZJzg8m/+4aMNi1H/qCU8K/Nq8FszvyKpUxykhi2m/foPpEClERz7aT9TVbXBSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116484; c=relaxed/simple;
	bh=c1JekfdBO66GzW1rX/7zumfUDS7si1cbVflnG96ZLWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdjymDtgLgeO/03e/WcKBeWUSKpOVBRPFy3PvEoZvE7LH3ts2SH0Cdm3AkXf1P0E7BAZ2l6jvmOqkFnE/NxyC6kh4y7VJi5zSoxISL1qb5d/57Eb5d4eyXfqdGlU0guC/Jluee+rMQCMGmGnJeysQweslKu/rpeShAPtoEdjct4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YD0ov2ZE; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YD0ov2ZE"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-89d4030cc57so1471157b3a.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792116482; cv=none;
        d=google.com; s=arc-20260327;
        b=ZUH9j2U/Pc8Iwm4ASWzyArz3BEJaZ+NW1Jk0xcp+e5jSBZhVhTJbP2K+9n+BzUkbzP
         GbtDOjzIHLre9pYB1kKw8ch4Sk7YSRpOzVMMKwFwuxmu0xH1Q4D6dO74aMrYUBkuGJf/
         0/HQ73FmBL0ze1E8SOjAEBDj24rOhzonGJRQROCsOmSEs0K9E7skwYVIo4Y/2wCs8lQs
         hpCeQ1lsiTOlO46xOYIADsDbmSN4F+Rzc4/FSwPhOUZ2rbBKNn7T2sDoLGOxuHIw2O0e
         5GMwMYJXJG0UVpldNY7ZPw8TTwsBVObzNjgPD5l6ZYKyu5T5ENWgSqwCUS1SCNkzIXh4
         IeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfCTw59gEzccPxPGXarkXIf1k8IEGa1ctcGkrwNA/P8=;
        fh=WATvt5d8cQECKaVt6ULKo4MZwfa3h1bP5zdbPWJ3rek=;
        b=P+VDx5MxgGozIDCxSVRmV1Ouzl5FllLeAPFEviGdqWYI8RmARyotDxhFeXdEpY5tke
         wYHtHR+pu2FwbTXOxSAQUfdw9vyLr1co5lN7hrpus06E1NXOoPSMyMOI0lKSyNlkikRy
         J8CWu9s/JzpmdVVKaiQX7Flfr0x3ebZVJnoXOaNZ0YyhT+C6E76D81OodTDc7wVZG8CU
         ar50Mont8/uITqvTdIKRDnZzMUDVBYi6yH6kFs4tivZu5FoIZW+xnKEbQjCN0WDHr4ZF
         HCC6rdceCqGz122KKjNxfOyB6b30kcVL4RTw+l3aVvt64cKagyY/UfoNMv3cGs6abGeb
         lJNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792116482; x=1792721282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfCTw59gEzccPxPGXarkXIf1k8IEGa1ctcGkrwNA/P8=;
        b=YD0ov2ZEy/XnJwKAu33RhFEk6f1ZWj5i9Eua2hl/2tj28Ramb0PQXsZE91TZE1koFZ
         Zm0ylJytTFIw/r2hJyi2kqutcQJRKPN3Z4/PipZriaP2EUCCcMbRR9TQvS0jZeWAr5P5
         BW+iYhoN23vYR1BH+74ZWVZJGikzv+3QXBAjfs5DU1bx5/ahwiRjT7Rt15GZ/MxYFakW
         hDWTUkic3HQ2v+97dEweDmom/Whcg7DZlnhHTCHQTPZg+IXXEoKrmSFSPi+NPP7rfAES
         VQpz8Czt8JszpyOb7b3knvi9vh7ESq1HVmU2zA6CRnmWMpN095C33kXmhkk4+xWMA80f
         ItkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116482; x=1792721282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfCTw59gEzccPxPGXarkXIf1k8IEGa1ctcGkrwNA/P8=;
        b=HtdRtwXyUh09G+TjcYQkNRiMo2vMHQNnK2TzyNtT/Ik7zOwTyio6W3NP360eAlSlBF
         65xaA7MJfgp3zwwZ2MkfwVaF7YVXnvdkVwXZNhgqyKbJ4aA73n5qljJFIfPNe1Kx41Jw
         MMAU3sYv3MN4KKhCk7M85yzvuvU1dQXX5CPxLJd4hKEaXBi2SRqMWmx0iepXjMIVs65a
         fEbH1BxauIuwZc4/Z+dXyXhMkFoqOYjaxCLtzD2s5phJUAADodtZ7Y5096J0iKjALH3N
         jLbzIl5tZRMsOdJ10vN1Kkwe/MouCBbR8OyW5ibxftmCIKZzdxV68TwpfIF4ZACpskh4
         H/8A==
X-Forwarded-Encrypted: i=1; AKwUvBx8lUow2gJIaLQThRrFtGdV79OWh/dgJxGARZgQ+u5wWBGNBJai6FGMEFRSzQdFiawsti1qLYw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3er70FYib969Ty03IdDjK4iC5xgU4na1P67WNkEoeUzvM4ZDc
	PcQ39T0aO6AAfUZdC5PHEvBVp+f0aayO0riCZ4korzc0ysm3J0GV7XlJfILKIFP/Ls1lMmaN+iG
	tzNVyj0ozIXerSiDeVCRcFqnAhFjFRbvzrhpw4gsw
X-Gm-Gg: AYBFou0yFJLxVIhJQHcuDppaJZfvTcji16uHJmcGlstd56k9/b6IdRfIDpQI18ii+oA
	sByfajhJlzJaHbtQBGx9Hxav27gYE8dM9VxmqBRGBaKYij3LLNDbgfROkfKacI42KC6rZi9hT3s
	gzwKfFyvN4/9qVYWKpo3d8DvJ4qT4DggewrRuo3BYawMVqWhdeNcQ4Xjno6UJeQE3OwFLLvywzU
	FOuEQjDrSv0A3tjjaJnd2Dg7sBXds4IW3iTdDKA7eNsEf4vfFDIwgTsyieWwnX6bQzzcNM/SpZ0
	QfkcDkkQL3Kr9/du5Ce5X6JnhAc49q6GyTfAddbzmBn8wv6YagwfsY5eht5CVbpwasZz+t5HhMQ
	LYFA9piJQgZQ=
X-Received: by 2002:a05:6a00:4287:b0:89e:779b:d03 with SMTP id
 d2e1a72fcca58-89e779b0f37mr2948665b3a.6.1792116482474; Thu, 15 Oct 2026
 19:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179147329205.58079.5847298721173675285@gmail.com>
 <sashiko-outbox-165773@kernel.org> <CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com>
 <852c9fb6-6217-440a-968c-b5ab3e22dbc8@redhat.com> <179210606199.96599.8994346249690707193@gmail.com>
In-Reply-To: <179210606199.96599.8994346249690707193@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Oct 2026 22:07:50 -0400
X-Gm-Features: AclHuK_xuEKifY20RXuv-jJv4fuayR2c_VgSKs7l2mBdBaAmWeWlt_XO4W1aGGY
Message-ID: <CAHC9VhRbdWFJapUxbOs68+1Mq_BtMqznw+hF_+zFwbOr=_becg@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: update payload_len when removing the
 CALIPSO option
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, sashiko-reviews@lists.linux.dev, 
	linux-security-module@vger.kernel.org, network dev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:14=E2=80=AFPM Joas Antonio dos Santos
<joasantonio108@gmail.com> wrote:
>
> On Thu, 15 Oct 2026, Paolo Abeni wrote:
> > The above looks like a pre-existing issue, the patch itself looks
> > correct, right?
>
> Hi Paolo, Paul,
>
> Yes, the issue is pre-existing; the delattr patch doesn't change it.
> The skb_pull()/memmove()/skb_reset_network_header() sequence quoted
> by Sashiko predates this patch, which only adjusts payload_len after
> it.
>
> I tested Paul's idea on top of both CALIPSO patches (QEMU, veth +
> br0 with bridge-nf-call-ip6tables=3D1, SELinux + NetLabel CALIPSO
> DOI 16):
>
> - without it, a bridged CALIPSO packet towards an unlabeled
>   destination reaches the peer with a corrupted Ethernet header
>   (garbage dst MAC, ethertype 0x0000) and is dropped; an unlabeled
>   packet towards a CALIPSO-mapped destination never reaches the peer.
> - with the nf_bridge_info_exists() check in selinux_ip_forward()
>   (plus a stub returning false for CONFIG_BRIDGE_NETFILTER=3Dn),
>   5/5 packets are delivered unmodified in both cases.
> - the routed path is unchanged: delattr 5/5, setattr still adds the
>   option 5/5. W=3D1 is clean with BRIDGE_NETFILTER=3Dy and =3Dn.
>
> Paul, if you like I can send it as a separate selinux patch with your
> Suggested-by.

Yes, please do.  Thanks for working on this!

--=20
paul-moore.com

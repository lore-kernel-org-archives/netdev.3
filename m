Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920342;
	b=vfNOWUs7Q2Tk7zNIWJDjEzebKHGo+FN6pg3qNNpyC/KL2vIvk17TS5T+tb2+Zxqs/48G
	 60sBv/7Gfbk8vCo9txN2T+WXFHqeMI8wYuqa8apg8At4DoqgoN4cAonf6WjtdiL/jii9h
	 ZxjCll5fzDiIMoB2qe4EpYYksmovkXHR38aSm3ZDNNL82IsmXFD7vsg3CDrlmG+dJcfgu
	 oH3ADa2ryCokreuWaYFnkxP+V+y5L9jeUlf4NoleSxGsd0rcdi9GbghMdyq6TjL/gj9EJ
	 XsanHUEJkUPzQ2fGDY30/za9T7x7i6S/irqvnq2VacpBNszwD8OvI801VxZUV6h7C0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
	b=RotyC6bZ6V6sUu63/HDv7z3BI8DfI/IjhQsN5L0g/4m1AwKLh0ZlHsOEz9VPzp5sEN6G
	 gWCo8I/yuUSSbmStLUgLIeRGJKa5+7cdzVk4KV7jMjbxpr0NCUsPDPnCvAb1pjXPCqThe
	 mkozdVpIdDAzln4tPlTfEJQkCw7+eByhxYgZA0oY7s6apTJyj7b92iNmGZneCQzisUNY0
	 aUVcYUp1bmGXeyplXKqWhA7j9ED3LqihBKglbeBurqMVXBRKMrDIxPxLhkKBFyOkfxF6C
	 rppTgM10inOtOUW0yXOq4oiB6x3Lyn408YQtY7y8IzMR7HYak3Y6XSpJGPuKhNdBeXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ePSbskAw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000BE606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 23:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 000BE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ePSbskAw
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso37363a91.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 15:12:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920341; cv=none;
        d=google.com; s=arc-20260327;
        b=dz9bhUpeLO3MCAkRS+Vl+YKTJyWDS385jgza8+JkuoXS/sfEEYnBOK0E93BSOjQx9t
         3RyD33bSL0rCkx8svQirsSu9jdEGJlOiaO2BWYTi6CzDYg1Ge5t8BdbD4TW1jY/Aj0RU
         77IEWM2ZBU7fHI5JPtx5/ASQbjHCe4eElOCfBYW7n2P2SyL/uCfCbuRteNn0kKsBccs0
         6lL16sc0xuYyMTPpjkVEnaWDAPS7huKn1a07PL5zwlKQYcO1eamoGqUxaC9/UL7NbRaK
         m4+umIxYkpghj+NqGNCjyUfyiTmbTTXhUbfqmHR6WT8OSeHgf2fc+LQz7v/ij6qeS2Wj
         3Q7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        fh=9EO/H6qmbRgku5vfQ4lvnw3OiABymkKhOBzRqes9TCo=;
        b=mGC7UGJDEkvJds33AAVyxJvD1tFmqezZpGdZbX7z6/lcTTikut6ox3gwtb3jk2kdXw
         37GxxJMxBeWKHHYdUCJ7Lo994gXnQHXpTsgHa51oUoDRBEdrFtBQdENhWB3hlJT/TYl+
         OK2kjYaaEzUOl76j99EdE3tQZxavm5qkpsZoY0VnRF42UHEzIFjccOd13cvETu2DTbrF
         DN4cNz4ISzFVN2DuSyUAxpVisnFRVh9dBH203tm/9SrYg+bXSw7HxalTNTQ/JJ0737ed
         W0jORnAdcaKffScfEhG74LyUDwl7/GNjymVd33l2i755YpO5f2SamHgFY8nUkS9Q/RSw
         Geeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920341; x=1794525141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=ePSbskAwea0d9B6NpBdXuFYsWvLDCToKGcxFrN9C/fQLJKxAOsbctr8qBrrZUslJXJ
         9CLcMCSIkKD7ZW5JSZB/FlpnXL7wVvbFlxAaV35NsJbH9Ct+Vj1AE0PSCxPZMXuxmspf
         S8DzKorUUKYgddL+oYJfDiSPHAXfQ8DdRb1gIJCpXWqjafW5TeuSLk2tBK8Xu5u2Toof
         wmqoUSerZIxxVmbDxgyvtDxt3hKRgQ27SfmnssLj7BFyrZUgbmKG7qeTDPokQzsw8F3e
         sMOi8Cm8Fp7SxcfGGOrWu3vbz980QOeeJXGWbY7zrPoyxcb1MpuMc94aw2AmHxsi0GQi
         jm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920341; x=1794525141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=SfpAkd2+nrpJPlhTdjKnFOkq2246mI7J1NzMdZE7UHKrLKRcIozS179YcuYFYE0Yk4
         YXPfQipDq85iwY/2WgRfFazRtHVv5OVq6UizhsA/mZW7tTdkti6/GJL9+wXuhY4Kg435
         BkhynUKegLvWSqgo7mP3Ztycrc5zegDt76IQvWrt53fvYkx8N9pqWXQrAxj/J3Nqu8T7
         /oS/hiAaKyJMVBAdy7vsmdMcWTQETfJPoSVbALoa3XBUL/DA4UjzEaRt+3/wyJGIxTp7
         VCYIdS3GcUI5j8y23cczbxdG/Eyfifld47c65mx5KR3ElrNxbTZbNsHtCXHqEnwhxap+
         a07w==
X-Forwarded-Encrypted: i=1; AKwUvBzvSSQkPi1YWaXOk/RLYern8kpgQRnaPgc2jPfa3SQY0q686aiS7Pbe/G1OynS5brxgBkBB0vk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HLBiUDSnHaI7WEroGk+3rIQ/mwwWSWI/6Yoekw2VJdOdZjt5v
	jjnVd4yDQdvcyEFOdYcvsypihNozt6fe4GycSX9DT04GgA9cAqAquaIbSG1nUQhr8/7YJyQpKOQ
	WVpZr5DNPoJUuTjFxWdVsF2fbcQfs0qQ7h1eV2OtS
X-Gm-Gg: AYBFou0X0O2UqgsVYkUK9MiqgYc768iigjDkjTCICs1WDCTXvDChnqWjdlqQM1HwV50
	tAp/pANtjsYdMXjXExsS9igh7DfPFJlpI6CCBkfjCKnHOnqxOR8Lo/XmBSbOMraz8B5t7318wCa
	n6TWFGB1pQOgKM3xVKOB6YSnrcD327C9m3A676LH//+SQFScQu5SZd0Ye60SB5fgEl6UJiYIOBS
	HgwgGXo6jAPCesq1Rh+gFPTYPi1zV0iD917Qj0QXfUVHqxLQhHp8OPNxXkXuapTPzDziGcpHmfJ
	G1pBCtpIjXinTLIEeZgkZ1DMVVjBHfdLHNvAfng4o8Qy+yHgCQBlXoLbJ1AHOIiF9ZrUahAR+l4
	FINdOLUvZa0j/2+MWPpjV7wGxm5C2GEdIO73GND4ibrlcc9HvtwPZNpcpr6WAwk+iIaDx
X-Received: by 2002:a17:90a:d88f:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3b0db6fbe69mr555739a91.39.1793920341210; Thu, 05 Nov 2026
 15:12:21 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:12:09 -0500
X-Gm-Features: AclHuK9SAmQ1s59IzUj_GoyUW49QmobrDei9zDR78OY4d10Tcv8mWs8d-l1JUg8
Message-ID: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:06=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Continue the conversion of users of the deprecated f_op->mmap callback to
> f_op->mmap_prepare. Keep things gentle this cycle by targeting simple
> cases.
>
> No functional change intended.
>
> Build tested on x86-64 (allmodconfig, each patch individually), i386,
> arm64 and ppc64le.
>
> <<>>
>
> David, Andrew - I wonder whether one of you guys could take this series
> through your tree? Since it's kernel-wide it seems sensible to take it
> through an mm tree.

Granted I've only properly looked at the SELinux patch (7/14), the
rest I've just skimmed through, but these are all independent patches,
right?  Is there any reason why individual subsystem maintainers
shouldn't just pick up their associated patch?  Yes, perhaps chasing
down individual maintainers is a bit more work, but isn't that the way
this should work?

> Lorenzo Stoakes (ARM) (14):
>       xen/privcmd: convert mmap hook to mmap_prepare
>       KVM: PPC: Book3S: convert spapr TCE mmap hook to mmap_prepare
>       mshv_vtl: convert mmap hooks to mmap_prepare
>       vduse: convert IOVA domain mmap hook to mmap_prepare
>       x86/sgx: convert vepc mmap hook to mmap_prepare
>       udf: convert mmap hook to mmap_prepare
>       selinuxfs: convert mmap hooks to mmap_prepare
>       xen: convert xenstore interface mmap hooks to mmap_prepare
>       soc: aspeed: convert LPC and P2A control mmap hooks to mmap_prepare
>       soc: qcom: rmtfs_mem: convert mmap hook to mmap_prepare
>       tee: convert shm mmap hook to mmap_prepare
>       misc: bcm-vk: convert mmap hook to mmap_prepare
>       ptp: vmclock: convert mmap hook to mmap_prepare
>       vhost-vdpa: convert mmap hook to mmap_prepare
>
>  arch/powerpc/kvm/book3s_64_vio.c        |  6 +++---
>  arch/x86/kernel/cpu/sgx/virt.c          | 15 ++++++++-------
>  drivers/hv/mshv_vtl_main.c              | 14 +++++++-------
>  drivers/misc/bcm-vk/bcm_vk_dev.c        | 20 ++++++++++----------
>  drivers/ptp/ptp_vmclock.c               | 19 +++++++++----------
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c    | 20 +++++++++-----------
>  drivers/soc/aspeed/aspeed-p2a-ctrl.c    | 22 ++++++++--------------
>  drivers/soc/qcom/rmtfs_mem.c            | 22 ++++++++++------------
>  drivers/tee/tee_shm.c                   | 14 +++++++-------
>  drivers/vdpa/vdpa_user/iova_domain.c    | 12 ++++++------
>  drivers/vhost/vdpa.c                    | 23 ++++++++++++-----------
>  drivers/xen/privcmd.c                   | 11 +++++------
>  drivers/xen/xenbus/xenbus_dev_backend.c | 14 ++++++--------
>  drivers/xen/xenfs/xenstored.c           | 14 ++++++--------
>  fs/udf/file.c                           |  8 ++++----
>  security/selinux/selinuxfs.c            | 24 +++++++++++-------------
>  16 files changed, 121 insertions(+), 137 deletions(-)

--=20
paul-moore.com

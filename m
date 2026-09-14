Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9946F484
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389765; cv=none; b=lkB58kYRa0NS3fOoxZWYvLqDsXZHl0igWPld8368wiyvMSChlINSAjvRGclb7agNK5VahMfEivLPbxoQ1OfEFxHgZ2mCY1WmqIFfPCLjkPUHATw6+cUT0W/Mmd6BT4OBHZBB4aFQEMhWQIvaKY2myWD2Vo/AQ9XB99wZ0QjfsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389765; c=relaxed/simple;
	bh=diVDcwyPgcEBBc+KdG1wDzNEKWqaSCAeLPsiKcrDYEM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Y7bQJosYNg5TDzd5NoQnjcuoIIYuLd9pryBx9b1BiKiMDSaZQGbdhIoXB5UoCoZCuGRWSlfFA6qFekzP0/kMjPEHkHAL/wrDrHa8Fnzyk/p85shrYaoXYvo2c4gh4/ZKzMxyg1I/1Hbqb0kncDyDBLAphKmIDL7+PLdtF2SMLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/VSxPDK; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/VSxPDK"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b899413537so3247914e87.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789389761; x=1789994561; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=diVDcwyPgcEBBc+KdG1wDzNEKWqaSCAeLPsiKcrDYEM=;
        b=A/VSxPDKF4U0x4K8hy3hPUhCk5NhbZmHVYC8yJ8lrLrWJtWTaKojwtG8FjcZiiy2q3
         xm8Xs0fvSrZHMEeRF7+5ZHY+stbXL+i1yLoDok6xrEA8oeF4UCzfSxOyz4eWPVRU5luw
         +1PCsrBEvQnYxu6IwZg3dsvAvxkGhFLFI2wwCR+P1l+Q1IOuhkzCchWaeABo1dhfQrkb
         +m0+MwLWFDuf7+4+9uIhozYVXryioc87YA76hvKAxkGYKBrALx5VA9lM57hwdItZsO36
         Csbw5okZQoqKTGD37Swdt8UTghR2db22l4psN6IM8dd8v/Q4nB5ppuY+4oreud22ZgdD
         DKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789389761; x=1789994561;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=diVDcwyPgcEBBc+KdG1wDzNEKWqaSCAeLPsiKcrDYEM=;
        b=nPRXd5kp1Wju+C5HGWgkPWYlvf7+Z5WDV6t095cNdUAzRC/IcpNRcZq4A8DHKsgNxH
         zd9HIte2qMDZiu5DO8FPn78o/DutCszSujNXahsd5+6feMSL16GJipTFCb0y0vechN4C
         wEoTB2lZt1Bp3wwMY+fx5vNnpxmY9W2+QugmyNZB0JiHZ2Mqk+lxI33ueJ8FW7NB5Xhx
         QGHUcapa7nMRSrRoqum4pY1mSGLDUBMmY6EMludTD5DN3BM0xgczE1OPfrtjncjCYAhh
         XluKj4V3voWtTszEsjSjczRzNHw0VYNUPXbxgoEPm4fC1F1/3xxLEuRzlYwxl8JmB8D/
         5i5g==
X-Gm-Message-State: AFuF++nMgD8yH3iP6CHL7cB7wGS0IUAU+JQKttxG3Lsjzl0WwZx9YPxh
	VYIqcSW+36CJkKpz6UeIuBnQRhehKMk0T3Od4j+YrpcTfuBJ1NN533Lb
X-Gm-Gg: AYBFou0MRfxo/tC/xQr+dQ+5aKZlFzqxYc/ID8666RwpLwOT2UCJtcLxz7z0eqfx+eK
	LeNXPrDnD4EUnY1oznGCH1A4urYlQkbwgApfKgsbBxG3HMrYUVV+1LwibepfVxb4EOU4FbvAQs7
	EWn6b6yjNZw+hbataAU5yV/vxb3nJGHnFV9SX3vhiIpfWoueE3i78/eE7fIe9g4Hm5nG3l+A0Mh
	1ujEFYQg2p4nALoDQC0mctCl3DYjjh5rrPGTIYIqsH9QLAzSM3SC7IDqOVFu3e3/VGEd2qFSml9
	N/VHbdTlbs5eh9vo8zDQjoj95s9Z4Xd9JwO6bsxAEXTsxQem1FM8M/rjFbB9UQ6BXfKIfE81Lz0
	JHFpkjsvt2D8mW/JmhJ3XwyeH/Z4hynfdHsDoaUBZr6x+SjnKTcRw3thIl8pwQ6cwBgPBzhwvVY
	VHFm9IyW+TZ85Qzbst5xMm/r9UC0Ebwny6/2X2LOcvWii1acCflV2h2f4MMzAiyuncLjTM/a6KM
	L6x6gzDM4ImCco=
X-Received: by 2002:a05:6512:68f:b0:5b6:4b2:de81 with SMTP id 2adb3069b0e04-5b8ae69ca7dmr639501e87.31.1789389761097;
        Mon, 14 Sep 2026 05:42:41 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0457246sm2444301e87.23.2026.09.14.05.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 05:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 08:42:37 -0400
Message-Id: <DLF1QA7MC6T9.3ETM9IGKE51JA@gmail.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <daniel.zahka@gmail.com>,
 <willemdebruijn.kernel@gmail.com>, <donald.hunter@gmail.com>,
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 4/6] psp: notify about a disassociation once it
 has happened
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <davem@davemloft.net>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260912200426.121025-1-kuba@kernel.org>
 <20260912200426.121025-5-kuba@kernel.org>
In-Reply-To: <20260912200426.121025-5-kuba@kernel.org>

On Sat Sep 12, 2026 at 4:04 PM EDT, Jakub Kicinski wrote:
> The dev-change-ntf generated by dev-disassoc was built before the
> association was unlinked, so the assoc-list it carried still contained
> the device which was going away, and nothing corrected it afterwards.
> We don't really expect associations to change during a lifetime of
> a netns but this is still wrong. Netlink listeners need to be able
> to tell the current "state of the world" based on notifications.
>
> The notification had to be sent early because psp_nl_multicast_per_ns()
> derives the set of namespaces to notify from the association list, so
> a namespace losing its last associated device becomes unreachable once
> the entry is gone. In that case - get the netns from the netdev itself,
> and send that namespace a dev-del-ntf. If the netns had multiple
> associated netdevs and only one disassoc'd we'll still send a change
> notification, just with a correct list.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

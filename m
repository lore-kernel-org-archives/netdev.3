Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225542;
	b=sqb5XLNdnXdUK1g2k8YVQKkiS06mQsYvCB544q2EP0gNAk4l/t081xtnwHNd+9/NL9wi
	 26lOJk4FZ8+FLDidrcryfYfOcMirPTsSoFo6fPtXp7ziyp6Fl8SFhteGZ1K2yczCBIezl
	 q9pps+sH5NopL+SC9rB2E6ZGsDlGb92lXDROrHIbBMGklWblb3p5v22M6smkcJjIKaswI
	 BIuoM3ojbAR2W7lJEAXwn6G11/Y3QRodhdQ3viefibOZLTsboCIEHGxaVmkIx918bP4Yp
	 Zwf/hYbWgnUtwnSeHhWZ93uAlNTxm/6rLJDCy1N7loaYjGAbKOukvVk678Jrv9NgT9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=QNVgEN77oBKnSnrKxR1ro4BNdRGvz1Bgwq5/dOCieiw=;
	b=qJWBdARPOZKrrfr9sr+1YKn269gZi8FBBcgCrkBio/wky1SFbdH+4hxdfFZ+xL7APSBV
	 fYcI6ui5urMKXQeZWiUhhZ03R2sN7jTcdAHneoB/K5pAni0XHjzGo+7W/zqB8bamzfQD4
	 O9KI17K49BB24Lo7iFKfgBUGuR6j5U6UScsnaBwhb6liwNso1KY3L/pLbXLDXfJLCe7sC
	 bIjgNBxY0ojHQrqLjl39iw5aWb3J6BDZUTkkeYqT/10qxZPRQHVzV90Q1jevw3Y0kR0Ck
	 on3Ytm4bB4S6V9LmFcjCPZ8LYjxy5yo8iTsf7h/3hodIt/+aOU5OVzkIKnsdEwjftBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnkFbGfy;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC22606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC22606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnkFbGfy
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso1087311b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793225542; x=1793830342; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QNVgEN77oBKnSnrKxR1ro4BNdRGvz1Bgwq5/dOCieiw=;
        b=xnkFbGfyThTA7sluMZxmZe/tFqpjJvZy3BeuOLed26PK8rowB56QV2cjDujQzKsnK5
         GmKOvl3lLNDF9C5LpnDrWNawxrKWoxxU70rlZ6iwYl0mxsIKQ3ly3Lill8mPGcXbrb4l
         eUX5LUBQiWAkI0dfYPxeTURpchTwdtOcDD+9FlP4DQFXuXf3UosexQz/ERHwO6vwz+Ra
         EU6Zrfns5SFmZ3fK7Drf1jdJHaZQHj2LozTBeFtqcK0uWlapx6tvjETJwJOym6hYNh4y
         u2VCalQu7IZ1Kd+AH+8oGmszIZmyIhJhleepD2SpasexA8HSFfh0mhOul5qFADVgwGkW
         bkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225542; x=1793830342;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNVgEN77oBKnSnrKxR1ro4BNdRGvz1Bgwq5/dOCieiw=;
        b=yJ1RS9PfM6PlowIhgJ0FGrxWOxQsStaVaHcC87IkemwsJ93i2/tknyH4g9oV1uY+El
         79E74QU8D/mHAe4cXhBN0AZezbY36RcV52TmUh0Xrz/J8e7GIReq/k2lwIO1MGpcvY6Y
         tTsQvfggzhwLeQpQr34ks4TaHlzE3fyR7t1DcTDLewKu3Liki5F1PGmUHc/jGV4WJCMT
         O+Vt8ZYguy49yb7lxjAy/FQcvYjUEJnz+0jSe1Vf7Ofchazjd25Dm66KYmqUhd9IFI2e
         mhQvnfYOOsj5s0VpAihCv3IeyO/XecYWfznQxnWxEX5iCr65Aq8DOdvsruRyNEHH8PaJ
         1yAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxb1YVNDJhl4ouYeuBDwTkxrA3bq6gYYZhjc4a5+HI2UcrkkJ5F+zzKjbowZttpFAU6gseiKkk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMo8qPzIpJsBVsJAee6hN5j7QZbDH2UvPiEB8bk1mXl4ErHlW0
	4EX6EGX2EbCmNEd9QI3xZx56ePrZV5diOi7LpCAbLaCC3jW62MoRfQ5bEws1LQ==
X-Gm-Gg: AYBFou3HYtQjM6C6BhNzxz7sJEIkaDW8e4eGPovd2mocQMXrOCjbFGJ9FTCIqKQqs4B
	1+eSN2feSgXgc0T5BJ0qCjZhre975nxKyaBq1kOKq1SatJHczrwRKJCOUlKxU6jhQrg4SIg2rJb
	PygDOKEFU+saf6YVSqfLImVPWCVBNdMIxhNnTyLeBhtFTBSn+r5l+m1CiA/T6rcLKgjN8GYU58B
	bTkHxkSbUAUeQtJjppA8aeyA1RvX/8Hgbuwb+CnVSpjgo0NqrSLbyUM9KPzJegOl7GouDXZ00D7
	r3JHZzCj4/Ks63/JOpQC+lKfZ7WXKCUG1rmID0Ek3731W9fxadgjvLcHrQj/KF26QlwuMgbD6Vi
	3D5jnv0+EhZV4kl0TyEBJV+QXgQAZpm+pVGikstUCnyTCd5yfBIWclSnMjk8F+8WgAhiy1AyX00
	jxH2FLM9od6TyaNgmsaolY/DQJQb5mygnDXyitqlWYWAPFovhwQpuXFKGY6BYUtrmKZIueMLlUV
	nl9V4VqJitXWcg4suVRvSLlCF9KMVntXDh7i1vwGEahF+X96n/9wb891yLUn4ri9bIEqFgjFlGX
	hrbCUGtRuu7AdmtbtSxEuNj/oIqIk7Ho1BN7WINRt2CFk1dUHQFigx8Q7IgZUmD7y+6InoEisfi
	e/Cd4fzhTXAxkY+buTJFJ1XcEhg8xcd+JKvI=
X-Received: by 2002:a05:6a21:4c0f:b0:3e2:ac98:68ab with SMTP id adf61e73a8af0-3e90246ec1amr2827999637.54.1793225541650;
        Wed, 28 Oct 2026 15:12:21 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc8f97esm4400709a12.19.2026.10.28.15.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 15:12:21 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 22:12:20 +0000
Message-Id: <DMGTEGTLTEUX.HECMYVCWNFQA@gmail.com>
Cc: "Eric Dumazet" <edumazet@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Willem de Bruijn" <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH net] tcp: restrict SO_ATTACH_BPF to privileged users
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Manjunath Patil" <manjunath.b.patil@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
In-Reply-To: <CY8PR10MB66609715D3216D1B10CC186ACF6F2@CY8PR10MB6660.namprd10.prod.outlook.com>
References: <CY8PR10MB66609715D3216D1B10CC186ACF6F2@CY8PR10MB6660.namprd10.prod.outlook.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 02:58 PM Manjunath Patil <manjunath.b.patil@oracle.com> wrote:
> Commit 5d39580f68e6 ("tcp: restrict SO_ATTACH_FILTER to priv users")
> requires CAP_NET_ADMIN to attach a classic BPF filter to a TCP socket.
> However, a caller can still attach an eBPF socket filter through
> SO_ATTACH_BPF without this capability. Both options install a filter
> that runs on incoming TCP packets.

Nack.
SO_ATTACH_FILTER takes insns that the caller wrote.
SO_ATTACH_BPF takes a prog FD, and BPF_PROG_LOAD is the gate for it.
unprivileged_bpf_disabled is 2 by default, so the load needs CAP_BPF.
An admin who sets it to 0 allows every user to load socket filters.

> Disabling unprivileged BPF loading does not close this gap: a caller
> that already holds a socket-filter program file descriptor can still
> use SO_ATTACH_BPF.

That's not a gap. The FD is the permission.
A process with CAP_BPF loads the prog and passes the FD to a process
without caps. See the comment in bpf_prog_load() and
commit c8644cd0efe7 ("bpf: refine kernel.unprivileged_bpf_disabled behaviour").
This patch breaks it. It also breaks a process that has CAP_BPF and
doesn't have CAP_NET_ADMIN.

pw-bot: cr

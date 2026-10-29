Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793292473;
	b=eBmzwn1M4GKHgom0b7p7QFqvd3rbgqz7lNVYT0aigth37iWV8HZUbQeq3IMzPIHBP8ef
	 tt+ZePlBpGeNBKFlYGorGNwAcUa6HXR5ojk73dzYLWdcdGq8lgdbQ+hXhoW/pOeHZTDXC
	 NqX/RIeNunC1OZb4abx5SF9qghaEFAEk99okpCYG5HO2EAkE+n/QzwptsrKxBaRAJw93Z
	 g4+Zr9kr3AH61KOiXGY8U6FIhGpAcqtRt92zHYYNXApa4WQkkqI6Ftw84+IPB8FJV3g2H
	 TJmVvEvj7qeLuTzvKYF+veegl+jm5YWTFnKhLppzFXmImgpV3USJ4nJ+RwvE0dVl0GQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Wsa/p8DFgC7lEBUBlf/AbqoCERuv8Vl8amjCmWqotBs=;
	b=BaTJTGi4i+j1zic9E3Khf5gdD0K7NUsWIpB8DnczN7+YOujuZ8Qiu6SFg4gzxjcwi3zG
	 zfWv/nZIphWEVVOvvqrAiDO9+49xZBcBDb6B4mMkltO3Vxk4Xi6nXdnNvTv/HcoElpUVo
	 RYsmSsz3K8JvdMzDkWAS8lFnNtCeZt0sGBtKB01eUJDQ0ywsBBbPOraYzNsB9h/kUiUZd
	 cfH0a/EyrYpyPXUOWW66YDUxmBcT+ZY2TbwghM6AbbLvg/9JhKnE3VQWSH96t49Y0NevX
	 ++PmR9vQKhGPVyyCYNgCnACbmaqtCf3rRgt91P5kO1JmFl4E90eAKNnaCowTmQB0D0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zsxb8QNM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D706606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D706606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zsxb8QNM
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so4340834eec.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793292472; cv=none;
        d=google.com; s=arc-20260327;
        b=KNN0AiXB1bsC8MG8bz9ItZ7E2nSSe7RuS4+TarsLYpzKs68iyvV0HDEBV6xMx483UG
         CtPm0dHBJ7tDgjFMNaexHgN2uuvSLGTzx1j+3w1hKYwLfj5xCiOGjdSTCKqfYkx5wLbk
         QvyhsHZv/XSdguuw7qFaWbdK0m/3ZXH7EZKqVMgJ4JSbK9K2A1NYv508UVMUIPVL0TLc
         4GM8eFBt8SZpFZoRHFo6IFKLBFICGIZ+cmyX77crpIss1QaQdCkCmEzJWbZT4Bcv7mUo
         RTce7h1O4Wd+WGjrYm64Yda5mjvBsedbqu91jMhuTwBxXED+iKYIGh6o2rEUiBs8kT5B
         tLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wsa/p8DFgC7lEBUBlf/AbqoCERuv8Vl8amjCmWqotBs=;
        fh=SrImo+sYXEfRH+Lnc/jzHS8K94caDC0WPJ1OSXRH1WY=;
        b=Q803hRxLNkbvjCV6NZFoZQ+gXQyBZS/0uIOMCkX3AFf4aPRxPNNDR9cRxnZ9Q1mheW
         1J1+yz0tNKz14lc50cJt0gUSHS2MtiwQ3G0QvkMDkkk7lmeO/YlFdGsf41GBJXwgYMja
         GvpMTzXgD2sisctvwBbFXrLu9JGyysCmmCeyJQNASzhnWymmsClL7B0ceygoGxr9KMVn
         w4wcXTKWCqHqPhuaM+P0cpS1b3Kyr8EMSeYo9aM2eaLVH4gA94f2exENZjYE5mmp8iMw
         Qp4VQxO6CDiMNw3D5du+CgA9hcweeHuGkJeP2HiHfT45kJW5MT3dIynHcP7cRDMpkMks
         uMSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793292472; x=1793897272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wsa/p8DFgC7lEBUBlf/AbqoCERuv8Vl8amjCmWqotBs=;
        b=Zsxb8QNMRF7TbZyVVzF7poTES6Uf4Mv5RAyYyFpBKODDngzB10A7xejT3tAxguFeNI
         0J7i3odSR1ZZhTqMgAGoI7M9Qafico1lRSDXvuVO1uPrri83kPCtvF/Ra5MsLyGQ8PZx
         uUzKJ93blfRoILI8X5WHty1tZFeBsDb09p6wrermm94tSC+lElC/BdYbff178ZM0hfdd
         NcV1NVNyy/Os9liOfD1sbfch5D670W4lEeWIxuVCe3hqOPboj2iWHGUEtIGAqhHI+uQT
         xHOIVSUFi5/ny/bKPcNN8Y7waCaeQgDFEuFnGsgYUtz7Zwlf1024la9jhUS2cbDs6o3X
         puXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292472; x=1793897272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wsa/p8DFgC7lEBUBlf/AbqoCERuv8Vl8amjCmWqotBs=;
        b=jad0LBCghCNjAgbCd4w9FMcK/D8uKx3ScEM+s/pq6Y5w7twK6Zu2vA1LcIidnmqz5G
         xh+6YsPexvNmZ25+UmAiqjuxqTO30RMOZXwrB6hbInAB2HkvX27URsjRpgKjnjEI3A9M
         Fn/VBlB8S79uI1zq3d1+i28NSeuSa6ZYrGVBYXRVJDNJxReiuxAUKZA3KcdYSWgBtzEv
         NYHsX58t+75iSooHPK45QcgKXYDzSvsWtAFPZ5IviQ9X6DFWOCMv0cFLSBwCU2u8lype
         Nf3az0GWUZih92HZOLvHA7tq850y9J3AnOR58ehtfvevMyCsEnCTbab06n0BQ1oeIaxU
         +7hA==
X-Forwarded-Encrypted: i=1; AKwUvBybgiKsc+lFiAkBJXkJk2squZsaUHtwhKjuF4EmNt/eA6itzSYHP8C8EXhjevMdOCZYjnXptJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPsiW+YODTzXEc5gPYQ42beni1zO7XPXeCwNg0YszVPJ23eKnJ
	njVA5H0m2aO/69HoYWc21BlSy+TD9GmXXShW1MkvXjCFXVE1LANKBwhE+aP5xE3jKv5hB6BwOH8
	RrV5CIAtlXZ63raEUcxUc+Of714Ave1+AG5rTMYc=
X-Gm-Gg: AYBFou392ahwixI49WssJ/iIVKG6MOIdhB5191YvrJZax/CZlJJSwqVUmmclhx/p7Er
	92FjeVo6nx8yAJa3N/qrzIu+qH8fTeSyOYfo961ZBvJLJmuIj0SjXhj1OhF+tXQYjtgaWxOdniY
	h5kcEM1WvbTnADkLu3VE34IPd7ef7mZnDW3W38EUD1312Wf9oBm1/0zAJ6VjY9nIPRHeTRo9cMx
	hV+0DzjLMB7QEF9gmv2qAZg5eEqAqjVnhhb8s08F3ktcx3IKlsJMwb3pyHDM7FHG4nIMA3MjkPk
	loVX06Nm+37V/usnlKtHshgJcVwL7RM+gfVJOaBBH/nsT+lMI7LwJKxNtF00E7uvR3UnWEm1M9x
	0VKaEU23kUHM5uFbW3Z58HuJzxbFYsu/CTKB0sUvyNaQ9wViJCLQUz6k4AI0ATbsefNtV
X-Received: by 2002:a05:7301:b09:b0:360:d4c5:7243 with SMTP id
 5a478bee46e88-36a2002d2cfmr7315065eec.11.1793292472441; Thu, 29 Oct 2026
 09:47:52 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029163516.2476127-1-hj351016@gmail.com> <179329193445.3327.7941488029152521409@kernel.org>
In-Reply-To: <179329193445.3327.7941488029152521409@kernel.org>
From: khj <hj351016@gmail.com>
Date: Fri, 30 Oct 2026 01:47:40 +0900
X-Gm-Features: AclHuK9K2vGmM-fNk5B8yoexTttxMSeGYWaivwlu1Nvp0CqoGWr9xKVGgD1Q_5U
Message-ID: <CAGr5VtPUE-gdEGDAnjuGvz1Pj1ROtKTavPYEPZFJXwtngVVEeA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: em_ipt: reject hook values >= NF_INET_NUMHOOKS
To: netdev-bot+sinfo@kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks. The issue was found by static analysis: a small checker that flags
values read from netlink attributes (nla_get_u8/u16/u32) that are then used
as a shift count without a range check. em_ipt's TCA_EM_IPT_HOOK was flagge=
d
because it has no nla_policy bound and only the "policy" match validates th=
e
hook, while the "addrtype" match does not. I then confirmed it at runtime
with UBSAN using the reproducer described in the commit message (a basic
classifier with an em_ipt "addrtype" ematch and TCA_EM_IPT_HOOK =3D 32).

Thanks,
Hyunjung Ko

2026=EB=85=84 10=EC=9B=94 30=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:38, =
<netdev-bot+sinfo@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

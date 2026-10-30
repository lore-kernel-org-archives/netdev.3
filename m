Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380964;
	b=BqBtSDCn5yrCToh/IeX4UAqUySw88bLOpqol75MnjK0D33B9lK+5DUFJiqUM0wy1jQay
	 vI/L/a6nkZcTbI1N57Umo70D76jWta9Vg1bggzSPFAEIVRa6W1PuhCRrBhXs24xqWTHkB
	 pyBBbaFshwfcgNC2lExQ2ECWWmJo+yOr6PqrGQBuQg+ARojwNbpt+0Xger5AstxsTtuwO
	 1Nxzo9IKkqdylQdkbJ7XhNH6un2FM3FO1OEeSaPKnFfcn0F02FjFTwyGg9OX7zbm8Gkc7
	 50DqjDEESSGfU20OfhVi39ZqW4bPax32tixujAK5rK2M9muQcZleO2vihjsoe9uvQjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=uJzytUwk23ovgU9TbV1PYDO56P/aKAkqKpMgUmlpTZI=;
	b=0fTVJWeNXBxxU02u4YzfLnmoKjo9ywksMcWMixF/Z1knxbwj9FLBEHGxJMJp+upsvdak
	 5PFjdJoSSXFoUH1K5U92BpFugKA4YYRQT2Knm4YMUjSbYZrdGd93fmbBB4h0dS8Dk88X2
	 noMtUQ+SrMXYAwsfXMzVM+VXICcFd0mLTRzJwWoAoeSVECyUqqT+6HXBob40nYXfE0o3D
	 Pc6ljSGk6wYRZQjoKgeI+LyoVmuiSb26Z2Zl3CBUPVoRGYITdA8+DYDur8MSygR5hMRpj
	 y1JuEhc2AlLdMD6bRxeYlLO2GK+Yo/mkosWpyLPs56T/qZ6cggPWa9OSKUc4Ps9DCTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzX5ZSDA;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5D606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC5D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzX5ZSDA
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eafb65e169so679690e0c.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380963; x=1793985763; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJzytUwk23ovgU9TbV1PYDO56P/aKAkqKpMgUmlpTZI=;
        b=WzX5ZSDAvT3UHZYgbL8cD7QJcaTmxK/HjuD8vHcV1VasQc9xQ/1M1gJxuClXJu3G71
         0cQx0epuDNOaiQwOWpcS08+NxBBSc0iRr/JOMYt6N5R38zdF7MCBzVPnaISrGxuraccf
         1s3eE0EVkRvBoFQxBfmv3RBoF2ppZMkkpZV63/6aOp87lyYoWXWNlRbY+eY7OGvyVIch
         uTmGcqODp80JiIkU29BFSREd2vV7sRg/hl5beD+UoeSOXoRxumAZoXkfD5M2s3w4pgRA
         i99tmffMIpgo1HnGF21ioAGGFkqfqvumHy0wa/qUyXSE3QMDmYVgml7u35F1CdfOUWBB
         jbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380963; x=1793985763;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJzytUwk23ovgU9TbV1PYDO56P/aKAkqKpMgUmlpTZI=;
        b=qoZuoVKAUW79InEQm8rL+KhgqYjhW5bWryYS98A3QJFoA/Y97kNlvivj3i+gLyY5Ar
         ZZUPvlnW2NQsQUyIXL60PxzSXgkJUieEqICqQ69ITei0+kQGQBd/QqNu2wvTSCEkyOda
         aHN7oJ5Bqcx6j4Ls/bNr1oRPNT8xjl7oL/4zbE1QIJvcCMilrhkQzhgsWkuPXtjnCy++
         4zF7wFR2Vn3jT1NZer7+V0nPiVYvECMKp7/U/8n1b9hj3QmnmICT/4Mooqji8Sz8vniS
         AhKKQxvPs9hBt0LN7yHdxK4n2SMP/xcu6JoOtGdSZy1O0PCOkDcSbDFoMerFRWFdzhfN
         Ti+g==
X-Forwarded-Encrypted: i=1; AKwUvBzxc1IGrNUb/yMve9Z79GIbDxCRLZbuXhb11FEBWpVN83RVJ4W2fj0p+wpZhNMeyB7Yuls3dIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLt97vPWFKnpmnOjwm6PZcazN1ZaymY0N3eJgdz1oU87SCa4VDD
	tnnEPhZqubP+OZ/BIFZY9IPuR9YjnyA4ECFGm/x3dDHjXPtW2Uj5+fxl
X-Gm-Gg: AYBFou2CTwR/iZotj2IVnyQwU2yIUs4Dinlp7edRKaWVCiNlL+TumQF8IzmpuzEJZuF
	UZZtotBtVzcjbJ9iod/tDRzKMlCAk+mw08wUFlr4blO6Ixp7JJNxCiYtAo7r+pVnXtXtBHo7Sq+
	091koPQ4JCr3YkRhdXt/U8VET6seZGbGcps2fGeMDiiOydPP3wPe9WHjvsT6yvLfFIweKfIDWIy
	vxiYw12ovWucGA3IZ+TSVcj/QYUzAkamEZi9oV+7baRRjJ5ljzysnBGLdGiDrAgXNydELNYb6Oi
	aoSe7LYwYv76mUIcpeNRoUV6HGNw0RHvLpPWzzlYBSAmfVrooqLKKt7N0W5tBFkekQ1c8IU5QqV
	5p8/uS2CvXYJTNfe2abBDDdPr9HIbR8fVyzxFaD2c+pVLvmhxlrkgro6tAKtSE5O3KzKv9JPObT
	4QlVcb713ZFGgm6qJXkAkAwLOvCZwCPX0DiwPY8gRflS3RoAmfpQK40qIvZzMIZimoETYtQys0A
	Mvk9zevqVDS2jdHJowgZKlDS2ZpDQS18P4cU87utWYkfB3fMA6Lz38QlTrYbUDrJuCE8nQdh7gZ
	SsiWqr7iBY3di1O76gKIoHGhYskP8TbXSbXukmowA4699RJdZw0FnbIveesB/5/DxHlBR/YoU9y
	Z3CkkeeET6vsTM6rhkKUE4wdANVbdlP/cs6GfaJJDY9ew18SH5gkCXRO2nPVqGSw4xquE5jwWwn
	nmafL4uIOMDNbzKZMFAg==
X-Received: by 2002:a05:6122:1d53:b0:5ce:b65d:22c4 with SMTP id 71dfb90a1353d-5ec6896b8b6mr1733742e0c.16.1793380962808;
        Fri, 30 Oct 2026 10:22:42 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:18:15f:b9ba:756b:b70a:a34a:8232])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c99e3csm3005317e0c.15.2026.10.30.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:22:42 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: David Heidelberg <david@ixit.cz>, Krzysztof Kozlowski <krzk@kernel.org>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: s3fwrn5: validate the firmware image size
 against the firmware file
Date: Fri, 30 Oct 2026 14:22:26 -0300
Message-ID: <179338094618.65825.9271330213423582924@gmail.com>
In-Reply-To: <179332821053.3327.2621510890857714130@kernel.org>
References: <179332800288.52644.4206885352837613064@gmail.com>
 <179332821053.3327.2621510890857714130@kernel.org>
Content-Type: text/plain; charset="utf-8"
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

This was found by LLM-assisted code review, as part of an audit of the
NFC drivers that are only reachable with real hardware (and so are not
exercised by syzbot).  It was then confirmed with KASAN on arm64 QEMU,
using a test-only module that registers s3fwrn5 through s3fwrn5_probe()
on a virtual phy and a userspace emulator of the controller's NCI and
bootloader protocols, as described below the --- of the patch.  It was
not hit in production or on hardware.

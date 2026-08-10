Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490793DFC6D
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372490; cv=none; b=eWkl2C/+FC8Dznzu4ngJLyHJas1EL0KQgKBLGxmCalNkFPFSzF7A0RGjmXg6I/La/1aUKr7mAPfNogYubK2z11GP0sLxgZrOMZsyQGT5ZDtYEKeXAlq6P19mCXNCN9nQBxs/Zss+omwywLitrygEnRVLMbBcJGoHZPIoA86owoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372490; c=relaxed/simple;
	bh=7KEflecgoowfLUJLwR3DQpUD4mN5lE27fl1+qWcheRQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iidrUla+GZhgq1MM3OKSgPY4T5cP7y1i10EMBB9uTQbZJXfZnp6+4XIaEkSc9jZTrcHw3FPBFXG1vY0Ix73Lm5xutkIHOkCRDespddorRudKC4N42EfGjjpH5QJPzq+2HvcwrpuZghSDAUhRAYIPN0zBoRqzpDa6r7djLUi4uWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO0XRtzb; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO0XRtzb"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6685001353fso1796941d50.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786372488; x=1786977288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uugsCIkopvzu5aV/7rdzFr3mTBNFfbXExreBkZkRUWY=;
        b=BO0XRtzbt9E1q+niL/DUzeZZFVCCf0c/w+eSUfwP+IBqoT8UZJOXp38jJKcAUs/eMQ
         YXAye+W/DVKMMmJxo5lqXxx1YV6KVi6xHs7G27wcrwdzGIjXtiG9ho1CNxN07xw5joQn
         eN4iUC4dKj1lILx06L5ZRt/EjoKTJuwHm60u6GfEA9/QHgAHPB4hblqXofQgzUeB7xm+
         aten3cri6i8NFXIEtAZol7QRQgkMCvu2bXVdq/foyQGCnXDRN+pHnHxMB2efG8RgayFr
         X5YjSajRpTdK2jrm3TQ0cF5+hBlNmT66xlyP2Gi5GXVN/xXUbV3prPTB8LFHgOT4L757
         Ob7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372488; x=1786977288;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uugsCIkopvzu5aV/7rdzFr3mTBNFfbXExreBkZkRUWY=;
        b=BNGckVAvb9d/BL/m3FSgWfIuZzkv8qrfSoEFkYrc0MR/jSuAssIvLbV6zt0GrS0CzZ
         iMEU9nEvxJvs6IWdUrKjIAMlgL2Jp2U2aQFk7VSFD26xbbK6vF0/HNsQY9hOda2eIoCT
         P9aMA4+kBCQx9ud90ml4CK/lQKDgjmlzzDpeokI3eBAYPx8ZxBZ969MBn+a6SqSszZGi
         1Brw574p4Cg5SobS0M/T3uFY0sZSqHE758cGBnDIpmmKkBGbhrpM9nVkcC5pX5FJW33W
         nb8/bkqDC57YazMBJYaLvAjBW1u0qJG4bcDPjfkar1ofsr1B5TNpikO487wETGy9IVZm
         XWWA==
X-Forwarded-Encrypted: i=1; AHgh+RrTnH3WKi0lt2BXAhTeJkO/JKe+JEz4iqru5sMlGD9miyZujHotN4ZjUyZ6D3t68HhOWyIa7HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEB6+vr4CAhIv7ilGAobkMujelkCIRNlPN/ODEml+EFtPH8c7k
	sl89vP93B090WxrL3HGLSgHfIHVIAM0njVnLQojQNczCHQqF80k+xOZh
X-Gm-Gg: AR+sD10CYBrd71DfBsCLdM+/DJLn2xjlWms0xB57DvQpPV92EjqtslieN6X8bSq/nbV
	01bYss3KeeFFW6EIC7TgBMlCUOQxjsbuQc3amtP7JFhdNRjWi32DGTAFBYnm/+vTddJC6iVVFER
	KO1sJdgXsZesAIKdxzDbdFxiA7CoVhcJcHXdqzd/O3MYxIrsRWx0/aHLWF8K38wAvuDqBayV6g4
	OyIYZs8+/0mDck2LbLerRd3k1grlC0bIA8DnzalPKsE2hBKn0kTjpoCR97/54KThg5j4PbMOWlf
	IOnuoVDyRyqyYI1zeoLMDkkItJywe/0hPdEyeM/JvkryWNAzed1+yCTAX6pMBtJ5PN3dS4BT99p
	nSGBkVe96vHJ51T0jZ82/mQImbBuLQpoRIBpBiCFOiU6fdiPC69WeuA6zdQcKe237QPBg1l4WYD
	mTufsY+ynRbZEMppveZIjsIQIzufrhwkG0N2pTOj5ILbzW06CmvFbrpV7Q1u26o911OByumD9aj
	KYZiUMLYdbuBuIsKDlYNiXIrr/+xC1epnpn
X-Received: by 2002:a05:690e:11c4:b0:667:ba5f:e32e with SMTP id 956f58d0204a3-66ac2e70259mr18465347d50.14.1786372488007;
        Mon, 10 Aug 2026 07:34:48 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbdfdsm6468408d50.2.2026.08.10.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:34:47 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:34:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1d4915e656c03@gmail.com>
In-Reply-To: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v5 0/6] hardware pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Enable safe hardware pacing offload on a first device (idpf), plus support.
> 
> - Add rtnetlink support for admin control over the device feature
> - Add device support to the idpf driver
> 
> Besides the main feature, also
> 
> - Small optimization to FQ offload: avoid unnecessary ktime_.._get().
> - Expand so_txtime drv-net test with hw offload testcases.
> - Expand pktgen with txtime feature.
> 
> Details and detailed changelog in the individual patches.
> 
> High level changes:
>   v4 -> v5
>     - Rebase + small kdoc fix only
>   v3 -> v4
>     - Replace ethtool API with rtnetlink
>     - Drop/defer pktgen patch: not essential
> 
> NOTE: the idpf patch will have a minor merge conflict with commit
> "idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc"
> (https://lore.kernel.org/netdev/20260803210707.1912217-1-willemdebruijn.kernel@gmail.com/).
> I expect that this series will need another revision, at which point
> that fix will have made its way to net-next. There is also a fix to
> so_txtime.py outstanding, but that is structured so that these do not
> conflict.
> 
> v4: https://lore.kernel.org/netdev/20260806232913.4020403-1-willemdebruijn.kernel@gmail.com/
> v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
> v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
> v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/

Claude has some good feedback, that I'll work into a v6.

Mostly minor, but one real regression with v5 in fq_change.

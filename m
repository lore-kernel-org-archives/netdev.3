Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E38308F39
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654497; cv=none; b=iVvDmpQ/vLNxw7eT6Nss9kDSmSnpVCXBvF8oKD9N9VdHhERXBjIa2IJt7HTpDtmSUrZTPRprUNFLeF8FbGzWPRDrxtzS0yELwZDOh0m3tsEewL5xN7nnMFvSbIUkYRd38wPOB7YA3Mp6Yz6otFnWWGY7peB2JAOc2Cil0baDsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654497; c=relaxed/simple;
	bh=Pa3YvauWFf1bhC+tatqe82CzP8lq+sELn0oMPCrA5+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeRrH2PC+qYBwd+9C2n+V6V17dUDqaD5wgciUh2TWtdxb/uuoXiwF+GrHrPYwRLPxyqNUFC2ERGXUZIu/05RD2JLS3LKerAuGsBLaFiwSW0fsPH26Mt+pa92hKuaGSaFFS08qjhvppFKv4fm4SbO6TmsiQ500svBdHmqItPCA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=stDY82kg; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="stDY82kg"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144d60be6b0so2173830c88.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 21:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790654494; x=1791259294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pa3YvauWFf1bhC+tatqe82CzP8lq+sELn0oMPCrA5+U=;
        b=stDY82kg9AlRKNsHJu9kz7uQrUhxvip5RTy3FyrE8Q8omaHpgbG/rPc6DDZQ4NWDtO
         S06biiYbptd5DGE6lODTog+Ijv49xMFsnbwcou2Ftokjas8m4iW5wnx5voYvFQO3WPy5
         5DFz34HhLvcog+kK6KB0lQZbA+zX5ehUixb+7NblWElHpHkWxyVze5UOQHRMq6wVXKMD
         /+5MMuoJa8jxMa0UbrpOtTWc/CfPP3dIcyDfkbYmO48V6+gs4WL23julafhnH0mp3U0u
         X8WkeJbFaIAG8kD0oBTJhPy13wU1B2opvHF1E4sQLYYMkl/qLbLKIvrp/bXIZDraAoam
         25Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654494; x=1791259294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pa3YvauWFf1bhC+tatqe82CzP8lq+sELn0oMPCrA5+U=;
        b=sqPoMdrUStl0DnV0EZnhd3kca0CXPJkeYWOuH6cFsh3HUu/ocuJ5E2O1JedxNbgfI3
         tjJ/klroc59GaT2J388x3sffXJwQ+ZX8RX2bi4oYSuUilPC/op8kAeR+Rm8gsBDD/2P0
         zLR/LZXmXjx8SqrVpts+CCkiw5sojtJ02qukkMKFFSO3Nit518M7L2cw30AVT5TqkMZr
         FMJ6nN86nbD35mDRaiUVISXx51YhaGX7TMmO9nS830zlOUbn1xjmRXgiLG+g3b6gdCXX
         rD4h78DoSLINt1y8gH68nAOQW1zclK6TjKfa8IkYzTO/c8OWWFAN5ehP//3Lnc9DAGYb
         V73Q==
X-Gm-Message-State: AFq9FYJ9NP/xsSjc00PEP3NlKu5TwMHfDGh98rnDU1jMp3+7StVc1q4q
	0L9LH2nhFvHnaCUjBWOA5/1LFey8NJ9x8SC+X43byMCeJfeoVXjAbQAM0iHGUvdNEdvQ6fMxnwv
	u+omJh7B+ThlJfwVokx162cbd8FMbiH7dy0TXb32I2aHvcGUjqA3vH5wfpGqEFeHRsBQCf2pO
X-Gm-Gg: AYBFou0POCpB9hMTSt3YHE3RXmIZqA/BUOciubxfJ5hacW8H7HDVquxJpuoeGFWpir/
	8QivEN4d2XSsaIfPNDJkkiMTBfEeupBleyGAAnqNZmLIRKIt2C7i2wo6e1WqYUsaIZK300upXP7
	340MPlewEB8iTNb3dwCU2bx5CkYN5Zghg3JmbBtDB7KmHCTYYgMkeXk8h3tqgHU0sSfKTY9frr0
	HrqcNpRC+vqKtcKZGn2MUSCbYJCSQZ0XUlBX5weDTgIVrlhOs8FaoxXZmLN1aqo7wDIvftRRQPC
	tBLtbc0IdfwnIJdaN0vbBbWAUOLvsqy8wwzjYOhByTC0pjbxkLC0fa2J6WiSNiw7mIlTOsmyxB3
	lqfXLg7mOM8rBtio8/AuW99KjxmjQHgsiO+tz4qo+c1ZOjN/9pC4GlFnw4e91an0gOkftL+WwBn
	g43dKeHfFezpmQ+Z+Xsf8ToTuaVJG5Cdcvfe2xz/bKE/42US0l+Z43Uc2EyK8mqxyJKw1ipSkOy
	BBaIyjNehk=
X-Received: by 2002:a05:701b:418f:20b0:143:2719:566e with SMTP id a92af1059eb24-146d077cfe5mr12164739c88.42.1790654493420;
        Mon, 28 Sep 2026 21:01:33 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145adbcd1bcsm37866313c88.14.2026.09.28.21.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:01:32 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v3 1/5] net: core: use the packet's L3 protocol for the GSO size limit
Date: Tue, 29 Sep 2026 12:01:22 +0800
Message-ID: <20260929040122.1968641-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.2f18198a6e1e0@gmail.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com> <20260928044102.1004310-2-wang.zhan@smartx.com> <willemdebruijn.kernel.2f18198a6e1e0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 19:36:01 -0400 Willem de Bruijn wrote:
> If netif_get_gso_max_size needs to inspect the result from
> vlan_get_protocol, call it inside that function directly? More robust
> and a one line change.

Or we can move it to dev.c, only one caller in-tree (before this series).

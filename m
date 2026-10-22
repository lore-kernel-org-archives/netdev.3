Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660585;
	b=5cD55JyQZkmisk/JaroqnMDf44axeXiQKXXYQVQ55p327ywjmAd9Ml9oUl2gvs86D+ED
	 Cmoe5JFincE44zxRq1j52wcZ34Ow7llk0Bf9qTsNz1cNZKc/AgPX7OJh1jdqdMiydiHx8
	 qSaQAnrPg67MWqnfTw1QJN+bpCNEG3xXMahK7RXD56dr1/pxYS1suYw1rbAHDBMPeBeXN
	 KkE1PHquLgG1z7+d/6nldn98cG5+BIOHqLKWoBM2u9TiWQg2a6CgRytnT4XFdJiUFkTOu
	 O+7N5PuL+M3Ws+8BRUc+f3PjcQCpP3Ojl+5Ig3psCR0VH4LZMkimTlnA4fzgyUKYGug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s3Hbpdq8bJvy97QquSYSmiPRVKUjmKCEWWHbHnrtGGY=;
	b=u4psD0IU73bZVB9LRZEAa38aUZSzEbjrPOj6FOI+Zma8n0UigYkdlDvo6ah+9IKozUl3
	 hbQND6PtIoJqURTwAdGOXp2E6pFq9rO4a0Q1yqsPRVv4mtTPO+mdA57y+GA0antfVEPpa
	 LNpCpzBuZvL8yL6pujUVgRmiEOPt+v3bQBhQFPMONDunxASmbuACBlNq5ZMZTYkQ/u9k7
	 hQZiZkX3vwybZFAaglEgS15vN50aSu8oeQhqzV7Xzyzl5qpK47qTU3dkLJObj6jNCORRC
	 ropWoYp2WZkC+8WQAyl90e/2twoKfpkKul1ptOLqP8KXCsVHMClJRBmBCvT/XxVzobQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AAEn501j;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B9606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844B9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AAEn501j
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-181516de561so326273c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660585; x=1793265385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3Hbpdq8bJvy97QquSYSmiPRVKUjmKCEWWHbHnrtGGY=;
        b=AAEn501jZOYxOn/VI6FYdNPLrY/oYI3of9nt0mbAfy8oGc1FK7wwLz6x3PxpReHu3E
         640YXtHra1T7Lgmx6IAcbSLbz/ki7fQWyAtsynbF2L/0oq+aGxr+fm4JLA6hr1r9q5IH
         FCHzenYHAV/5s3NAsmh+fNPOFh1uvA0oU3fbv+1X8B0am2fqSpjye5mbpz/YGLE0q0Ei
         lOJJvwJTaNsFgkG9wKedi9AUu291lV/GH3+YKbL3yu9cB/4DjGsMcyU/8VD02vRT4WDb
         PFpgcdkZuy/RKbbT1TcPutonfq/0LuhFsaXvzrPuIlIgmEG/HCwiHiniwVFWpYtnRcn2
         6tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660585; x=1793265385;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s3Hbpdq8bJvy97QquSYSmiPRVKUjmKCEWWHbHnrtGGY=;
        b=CNJ311AMF6DvVpGsU5LVzWwtVXrGMoDG7/qGGRp0FX4CcX2P6nhAvJqLglKAPJ54iP
         rA2fqQwI8vkoxx5BZxzxOW/xDoG9CCWX9UOoRObpUHtjjkch2v6BAtuVfpb3Mr9+B4Ki
         EzCEvHczvPYjQIP24zB2sVi+JRqY9/tPjdnH+nc7soTOCkWkmDTEzK6t2QfrXX4jEY1U
         uNDPMKqvlw1BwBez0swxWcYV4s6YqDQ6FfnhUrqB1uoq/v4tGgPNPShPhrsUAOSc+afW
         PJw6UqmY/7eLYssiK6X3ceKqe7TB7FFiAmvfpwFqlN08NXTvvvtlTX4eL15gePtvwpLv
         fazw==
X-Forwarded-Encrypted: i=1; AKwUvBz6WQ5cphghZB2EJKdL4SM7wV7ob/dfvLPktITyeWXkEwbTIpyDlv9QENLAHPF7PgtQU6qpEMA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKR9R2eiyZpIIC3WpHFhr6twQss68JzPrPpNtQLBsY0Dazas+fQ
	EoXeavpV9MuADqbuHaai7v1LJvLc5chdFcfG1UZh3GpBPNJ0oMQZ0iWT
X-Gm-Gg: AYBFou0De1Te8U6bYZSgs57Q2CeBLcCHW6h8sWazPQ0MZ/UjeRSNO07yKa2kZKtJEXH
	U7o0xUT74SskmjsNzSqGY36KnXqqGN4MX1Etce9pqgto+/yOaBe4+/ssHGgwv2WemQpYmiFHzVE
	hzpAUtdWU0QSbU/5JxvENzMdK6N+Su55RGpjypY7WAdbLBtJnuHZsvKZzQmew1sl411f3xNk0Cw
	+txrtUmbnE0PVhiEcAaExZ0ld9abqd7LYNIGlOv0xQcCSNTJf6j/GT62hQeeOPqc9oJQhAOlbg/
	IRUEioAMQ57lTlndtXt5mZmUv0ahvu/er1b4gpJA5S1QKIvql901sQMNmERxvzQz9aWfaGVwdIi
	TmhFaQQMsExH/Yaxg+fWgPrZi4sUlineVmvi9ovZJLIJ5cjXvFic/iIxRYmoP6relq+DoqrL59J
	UftVTLk64Ppr0BnJiJSMr2+Pm2u5gLxwBLbuiOutL30bIhWOstHXYISghHpREvBTipHBfS0qVYV
	dprpOPmHPzVNFdtTXPc6WLHuQeZ2feY6HEkUmcP8uvn4ASEBo0Ou3a3w8ZzNd5WYFYUGyxHHzWt
	PCi7FB28YVELAoH+oVQ=
X-Received: by 2002:a05:7022:127:b0:14a:6a66:f6e3 with SMTP id a92af1059eb24-192f4fb0ed2mr3798839c88.20.1792660584630;
        Thu, 22 Oct 2026 02:16:24 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903ca044d4sm14095227c88.17.2026.10.22.02.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:24 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: VLAN operations emit wrong link event types
Date: Thu, 22 Oct 2026 02:16:18 -0700
Message-Id: <20261022091618.3651826-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

br_vlan_rtm_process_one() reuses the VLAN operation command map for
the RTNLGRP_LINK notification type.  A successful RTM_NEWVLAN therefore
multicasts RTM_SETLINK, while RTM_DELVLAN multicasts RTM_DELLINK even
though the target netdevice still exists.  br_fill_ifinfo() also omits
IFLA_PROTINFO unless the event is RTM_NEWLINK.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1:

  RTM_NEWVLAN -> ACK 0
  link notification nlmsg_type=19 (RTM_SETLINK)
  IFLA_PROTINFO absent

  RTM_DELVLAN -> ACK 0
  link notification nlmsg_type=17 (RTM_DELLINK)
  IFLA_PROTINFO absent

  target port still exists after the DELVLAN

The kernel's dynamic-debug output independently confirmed
br_fill_ifinfo event 19 and event 17 for the port.

The request handlers need RTM_SETLINK/RTM_DELLINK operation semantics,
but successful VLAN changes should emit RTM_NEWLINK, matching the older
br_setlink()/br_dellink() notification paths.  The 2015 notification
compatibility fix established that ABI, and the later RTM VLAN path
regressed it.

I found no matching upstream fix or CVE.

The self-contained PoC and full serial log are available on request.

This was found with a multi-agent workflow; both event
types were reproduced in QEMU.

Thanks,
Cheng Yongkang

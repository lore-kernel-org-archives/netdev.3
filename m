Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851128;
	b=hzDUtyL6ZD0p+OwbyqXJaiuhstysSBciKA1hY8gGJvW0WNv7ULg2guGKptI95swwRlOn
	 2pWZBhCgSI2woI4T4P3H20/GQ32cVfZnsTtPYi59kbANUtYbuEjnyAFtI+u15veFzAPnD
	 qhXm1oG9dIXYZkT9FXRrwGC+MqaGDxuTmgxIlNvGnVXgh+8AIRl4ePvh1F/N7Pvo69ozU
	 Pq1/PX9cdM51/aR65SCNVFRcKLb871wY3FNzEfmHUl+rr6oCs2aObT8NY6TBi9vtGGfuu
	 rd509UUeWiR6tcKXRdMtNQ4rFgs1wOQ3EmaU8tMQXVHJjNFkC58A6STxMlqkvgmlBVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CGYl3C86hfPgxp/SJNcGcvJ+3Ge62EjjXQJjZpVCIVY=;
	b=1OBwqW+yjFIBM80cNMiprhzKsNLUDQZPkmir5P8RI2IVdlCvPk+U0GZ+lUSGRdHXyK5L
	 7WswXMNTxuLxos1Zm9d1FA12xnhJC8U3Cj5v4M3BjaFymiCkFiYAIacWPbAo6V8o0E/x/
	 46SjH1w10ITWM3cgt31YMc5Pd6kAui/ARBe1DmZkD4e7mphCVK5i3UvUXAyHfFiAbYAZE
	 4BVfmoHSYEL+taSt09YvbWlVWWxdisN884xpiBcmPQQJyCuqBuHd5NzskHI7x04/3Kbvd
	 BViBOs9QgaRvJ0zGJ6ndEt3AdPhgvqkFjtXzF5iLXC6fDgToZ6bec4YcWuCTt82J4lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="qN5mw/Re";
	arc=none smtp.remote-ip=74.125.229.138
Received: from mail-dl2-f10.google.com (mail-dl2-f10.google.com [74.125.229.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ACB606A31E
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8ACB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qN5mw/Re
Received: by mail-dl2-f10.google.com with SMTP id a92af1059eb24-143601f9f98so330494c88.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851127; x=1793455927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CGYl3C86hfPgxp/SJNcGcvJ+3Ge62EjjXQJjZpVCIVY=;
        b=qN5mw/ReCB7w8Fr8wpbp17/Wt0LcVzV62xdjLQJ45acFlyX54MQXD0yvZoA6L8h9UW
         SiiD9IQhqeUWGygZQriJ8FqLzFn9RLTs8083oNXLfcKarEq3cvER4owatxsYqXeq8Jkd
         W9C1Sz6G7shKH5U1M8kbiBE6OgQDySs4MCSjBmrQqu9wSo9UlV2qE/T+bfMdQ+GA5fU5
         r0f7O+Yx5nywRv6ffU3HEQ4x2mFkftgZJu4dvT7m66Afx1IY4sR/aYG94t4t1bczeWFi
         mZHgp8AqWv99yVVShTVN2KQTRP9ugWMbOdhS++FaWnokQ19pN6smKvYZi51G1H5Ozps5
         0+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851127; x=1793455927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CGYl3C86hfPgxp/SJNcGcvJ+3Ge62EjjXQJjZpVCIVY=;
        b=QU89ETl3cmjX60yHC3zOvAPlQxkcx0XcA0XFkGQHhPTeonLv3wpznB2+fXGPbdr64w
         gQ2c2T1/OPmYHaL59WvwMGo6fyi/VxQwMS2pzH/fo7iev9BGSK8ihOyp+xu0u/tGyxKY
         deJppjKfQMpR4mGoYkNq7Nx+ZJ6bUOHuxXI+t6Ar206GjRyZIqqv89YcSJ0o561OltBp
         emhVz6Nt2C2USa1vHPag5t18EMrxQA9/hnjWxLlwMkl/cAV4fc0VX10d4Fl7+PNCtu+O
         KgoGBtdks1pB0i1xk7wFYvvkiwzyrep0H4MlJuV6TO5Luhzjq0v93BRSbA0+pMPfUar1
         xi/A==
X-Forwarded-Encrypted: i=1; AKwUvBzx/+n2l332q9QyRHMAteRh27lTUQlKBuJ5RzuPx5ygjNkttXm/gnGE+vdJIE6tup3tQe35/GM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI18q6xO5G4Ne26AaM7dP1aUvBc7UQGGvyAf3zLWM8Yx/oinZQk
	N7Ume6h627uT9nqNDgWakrp3wvwICt9+UEK8pTSEazf/BHVyaWmLHVwc
X-Gm-Gg: AYBFou0QXZm3/qE5y472XvuMqz6Pjy4J6y/MR3Ws1vl7x2CevGitYDBPlxOm9Nb1NvC
	8UI9cFCEJR6jffTnwCl/G2P9lz+KGV5f2JUpqj1TnsHuIpJ4khK0BJOD62FZWOxgwdh1pvMhO8t
	sHSSeGrgl6QMrZ8yq7MV4g0byPhfRwDGgFCB9v5nQjqCIg4VHlLStnHi/bYMPhNC45jBGPE/RMb
	HlM/z9M+mKtuCGfGfXUDsETU1dKcvAkcB6r7sgGNix6YX8VqOwyFZguSEFo8Z3smUpZEugzokpv
	HQo0tTnkk+YysYBrliqLl8tI2PJsjFFysCgDitStm9jJXerx5BAv5S935GGcgWGPDKZKfpa3cG+
	e+XTLzp2tNHmi6Aju2ykwzigG7k6GNW1GH1xwSC3sjIWNcHf/RN0rptsdRJVCAc1wvFE2+Pi16t
	mOihf7b2DpZaHO/OFzlRdjJHLSR28qr+57OiYOY5HCHUCHSHXpwwHeaAGHsM6tz7KGZ8zf/g2Ic
	5s3mHU4LbzqsDw520Thr2pK/p91qcCok9at7kkj+HXUX89YUvuTIxp1LUOHUOoRhyTYnrAvX5Hv
	8cSCUkQ5vnU0+4Ef0p/iHiLU
X-Received: by 2002:a05:7023:a8e:b0:14d:c9e:a356 with SMTP id a92af1059eb24-1993571a2eemr3465311c88.12.1792851126409;
        Sat, 24 Oct 2026 07:12:06 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:6887:87ec:7e6f:2a79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19a3736d16fsm6366905c88.12.2026.10.24.07.12.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 07:12:05 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v2 0/2] xsk: fix multi-buffer TX software checksum
Date: Sat, 24 Oct 2026 22:11:55 +0800
Message-Id: <20261024141157.59301-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261024091256.17918-1-testwrzwrz@gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the AF_XDP multi-buffer TX software checksum fix.

v1 was a single patch containing both the kernel fix and a standalone
selftest.  Review feedback asked to split it into a 2-patch series and to
reuse the existing xdp_metadata selftest infrastructure.  v2 does that.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

On a checksum failure the packet is now dropped after the descriptors have
been consumed.  Metadata validation makes this path unreachable in the
current copy-mode implementation; keeping the defensive drop avoids a
retry path for an skb that is no longer complete.

Patch 2 extends test_xdp_metadata instead of adding another test harness.
It reuses the existing AF_XDP setup, packet generation, completion, and
verification helpers, and sends the same UDP packet both as one descriptor
and as two descriptors.

Testing:
- final exact-else patched kernel: xdp_metadata 1/0 PASSED
- same-config unpatched kernel: checksum mismatch, xdp_metadata FAILED
- checkpatch --strict: 0 errors / 0 warnings for both patches

Changes in v2:
- split the kernel fix and selftest into 1/2 and 2/2
- reuse test_xdp_metadata helpers and reduce the selftest patch to
  86 insertions
- use literal else and unlikely in the checksum error path
- document the drop decision and test it on patched and unpatched kernels


Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  22 +--
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 126 ++++++++++++------
 2 files changed, 100 insertions(+), 48 deletions(-)

-- 
2.39.5 (Apple Git-154)


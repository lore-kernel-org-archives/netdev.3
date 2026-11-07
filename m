Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051262;
	b=2gu3+HInTv9LxodnCaGOJehE7rGonchtmwet3iLA0d6/ZO8Ce+JEMvlPJB0EUZePiXWd
	 JKQQIlmTZM7i//1lY4Xvz5492pEx13wRM7ehY1FoysQusHru/Dk5KX6Je7o/xWPFKziyv
	 QprgMkkPsEYfhOYF2mlCWI719SX3QHMWGC6darIDcGqYT0KJlwm8rnki5d68UlKRs69ce
	 dgrFpH0i9FTbZBlWcPFwHWg3dMy5giiBmN5CSWPFCFEeXpnVA+YJatvx6ybVkhGbvrFLw
	 DVm/ZJP4geFysZs75UQ7bw2lMgOzJviZc1ZIR4dBMjFS7U+qvNOVeo14sklIokmLS6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8Y4wuXjHScY3iujceiUAqjM+xKc+nuPmQr+0vb7xGNE=;
	b=PjihWr5cO6V+l2Z3hQFnNeL2avnBZj7sGBU4TTG7c9WBdwNQ+yk+YKKSiqCxzRuirDLy
	 jTr2DAAr9xkxIqamzt1IygzVEHflI19Fsb+U9nIbS8jp6SUEjAkDsFBxREjj3MrwNb0Wz
	 GGkEV2a5x59uYP58bGWQSndjYcIvOSevDKj8mL85jdWlBHt/YYr3gzBGihSt5eJ1MFY9e
	 NoNvi4O3IbxnvVFC6O6AboPiW+9ZLMSHatZpQORR9cZh025u+jWCWG0tuWbgiXDqqcw4A
	 DSUbHBPVoWPs5xQX8/tuw7KCFNtfppy26utOi2KL993N1ZvhPVo6BmpK4dR9e/ypq3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m9zxtFYa;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51A606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 11:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D51A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m9zxtFYa
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b306bbff8eso11227077b3.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 03:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794051260; x=1794656060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Y4wuXjHScY3iujceiUAqjM+xKc+nuPmQr+0vb7xGNE=;
        b=m9zxtFYaW4rqF4n2ETlXK1c7uIu5mPJG+AfCoWhTQmmytmIZYqW9GyZfgAfD2t4L2t
         SEQ7u2uUbqPOvBHld75cet4UMRPPOQ3RlpurtiqE8g0er+0m5KtBGKsE+xAnaIXmNxw5
         YKutkRPdD0O94ZXff70gZJP1ft+wwWHQrUpCWoXioczrPuT1aL9PzI6m1FcxS27EmDpx
         pTx3IM99eDbwudPCUoAbNnH0dr9jsMMLPeW72BI2XgvXPIuPHbz9eCsQ02jOSE0GeRA1
         faY2/UGfXDZz3LA+7B20wZNiNCAZgPH2EeN0uyk9Be4ERctQjOgcsl9Kt39a7P0ZVZ1x
         z23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794051260; x=1794656060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Y4wuXjHScY3iujceiUAqjM+xKc+nuPmQr+0vb7xGNE=;
        b=ME5oKipV3ykhcGwCf+78nDTHRk/LHdB9+llwSxd6a2ScsYmPcIvDzQpvXpUcBl2U85
         9c8dd2IDiOOwnHxjEHrseyomU28rRVqV4NRe4GijANcoLGLb6r8BhPnvbbES2NSVFyCU
         EwWB2LTKt5qiQLL4DTBGKH2LIrrZahe76RCsOHMIQCVQsumI/J77PcaLIDePZcWO6IvL
         MrlcVzIzYTcsjyzXi/5c53mV/VZ9eYfy7WYwHG60QQ7MrDeYqNHD5roRM0qFPH8J0aFb
         Cm7xl7WWLoHBftQsxVl4yv6kT7SxFD0C+dbC7D5lbZYztm9iX/o4MJgbcjipPOrp3r2+
         5P+g==
X-Gm-Message-State: APuU4Z+cRybOQesnG22jPbZZwqJa5odIciLrA6+NQ36PePTUVnutEgob
	PO+H7kbqboAxDns8vCZK1A1k+9aydk2kTDzD4BmiqzCNJkNJu+qqZ47EFR+Kkqku
X-Gm-Gg: AYBFou32OyuABwXGqvg+jl1DfUbjrRvJZAHS5LIb1nHmIBLCYCegqXSWIFlDMNV7rkZ
	1SQhCfIvS7kirXBWOQCZ8ee/9+v2UthOeMd0xQGujJPhtPbnTxk89lp960fw5hd6p0ykQ9/ryoK
	Xb0JEOWESeBgKX3SR5aRjKZFSd6E1SA/zVmkQqjzbJB3Lv7pMq0Xj+TCp4QjND32tDnLFx7sEsI
	55n6kbD8S3LbOIXfeMheOmJ4b9f393z/jaQ2sTgBf1HtXM+jhdAT7cFcJlRTe7/IOm8XL7567k4
	l/9NAstbwa1YUfNYf9XAxmukNQ4A8ZO1K7OLF1h34m0PQe7Y4Ozd0YZVB5dqlObXr1Jaaa2yl/y
	sjXckb2r0cz5HdU+iW8eCIY87AI5NO7nWARncHLcN9WHd6MbxttiYe5UBqyHDi1j06/uZN1ll3u
	zKzLoHFcuCZcGxWfIZiwLECUF0LALBSnSixiMwubKYjmPydu2etDQngqvu6Pnye2OiIcuoaWCLQ
	mW46GppkPS8Z6IXydi+6vQBxR5Bf8wQSdyiFS4cLr/+8xEUnKCuGtpCvHjYFs8QuZ0aBHA4SZM1
	oovQqWCIENJw/OM9D3b+6ur2
X-Received: by 2002:a05:690c:82:b0:8b3:150b:43b7 with SMTP id 00721157ae682-8b3418dfef7mr27601517b3.22.1794051260195;
        Sat, 07 Nov 2026 03:34:20 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f2d5dsm40084597b3.2.2026.11.07.03.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:34:19 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paul Blakey <paulb@nvidia.com>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v1 0/2] net: openvswitch: fix a feature leak on a failed change
Date: Sat,  7 Nov 2026 06:34:01 -0500
Message-ID: <20261107113403.797779-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
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

ovs_dp_change() records the requested user features before it calls the
update that can fail, so a request rejected for an empty per-cpu-pids
leaves the datapath claiming a feature it never enabled. The tc skb
extension key is a reference count shared with cls_flower, and the code
that would keep it in step is skipped on that path.

Patch 1 fixes the ordering. Patch 2 adds a set-dp command to the
openvswitch selftest tool, and a test that sends such a request and
checks the features the datapath reports afterwards. It fails without
the fix and passes with it.

The problem turned up while the YNL spec for this family was being
written: describing the ovs_datapath set command meant reading
ovs_dp_change(), where the ordering stands out.

Signed-off-by: Minxi Hou <houminxi@gmail.com>

Minxi Hou (2):
Minxi Hou (2):
  net: openvswitch: do not record user features when the change fails
  selftests/net/openvswitch: check that a failed set keeps the features

 net/openvswitch/datapath.c                    | 10 +--
 .../selftests/net/openvswitch/openvswitch.sh  | 64 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 50 +++++++++++++++
 3 files changed, 119 insertions(+), 5 deletions(-)


base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327271;
	b=v75nARXT77/Fkjswz6oDXLBRx2MIScXXL1puPpKRQR3qdT4son8UnZZ/OqKzfmY2QKlB
	 rUmVp/VjCrxpwuWrX8Pcs/Q9FzGixuXIEc1vsU7P/aNAP92HLxlRdZKNg4+5ljYAp0wQR
	 RV9HzBDStC56ua9pn/1r/cL0zUgFcWgK4ZRBUIg6c+mxKznSQfWQLJ40QsGisyAElgICJ
	 Ii6I/ZL3FQ1yRGT9CyAF6RP+lAW1hH5rxwHslV6lYVFplIVStB7RztlJrkkowHz9ZZWGg
	 dCbifdyvYtGCQDfI2oZkCcJATZXvsuuAMlRdD9ybZH6tjNpkVThXYtlhKd1R9+5HCWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=e25FFx/VLY9F8YuTS9P6G9MrlhtdZ/ItqJ/kjUZtCXA=;
	b=2rNrMberiuBxQwKNEo498JVGjHKWpcZAsWjHkuv6lbQi044KJLV6fTkfYP392roUznaj
	 2DkXQoPAYJzE/Z1JIWuxNCZGqETn3bd0Rtb+UVK5rifAHKd4aoCXA7J6S8tGBPrQw2lMN
	 UUyTOMoer6eiVs+ZBF9xMNFAU7Uk7RK4c/h8q4A7xbCpDWQYDtEuYYwcLDnzcgn6ynDcg
	 72Vbz4ddCaKsJkFj8+mfFXWzipRbYDxzzOfgQ1UG7ZdnA4Rss7+krvfCWu0jAtbxlSyKN
	 FJ3XOvwNtZC0sgihxjqBPHexPXvvTAC+mgLs9dmmuVMREGZY1SgdrzYW9zduj5Fv/8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LiQ+0au2;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D660A2606
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 010D660A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LiQ+0au2
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4af52002471so3116155e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794327269; x=1794932069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e25FFx/VLY9F8YuTS9P6G9MrlhtdZ/ItqJ/kjUZtCXA=;
        b=LiQ+0au2fs2AIYPO+t0gImjc29SqZKC3KSmiSxIxXFAkNaE9g6FBmYxZHplOSsvdnm
         68B2t+fVzRayt41s78HAW3sdj6z92DwiDP19/EpDNsh+piKfg+/b8is9DD5Zb/hkxnfV
         jo/ewZ5DuOeBBlDmxkGbHn7HtIoFIMtOQMn2z31V1sJL1n6d0bqf7S0A39KLnV+IdKbg
         VKvNXuhPuPfctkuX+UhverVPrndgILqwhT7GCDLtd6vsxQlBIHIO66VN6uSrpQzyFRkS
         vPFCpjMIpJCoPUXXG6dC3ux5v1HcmOTWtpcMrQXxDVzUOaosJQ18XMld9WW+z3e1fC8q
         maUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327269; x=1794932069;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e25FFx/VLY9F8YuTS9P6G9MrlhtdZ/ItqJ/kjUZtCXA=;
        b=ray1c2B2AmTGDHmRhdJuwC+PrW7Ae0ySO9Xl8MN7MM1HhXgysPzv1UTCGMHfmu6Mla
         i3Z7qy5rzjcZC9RPTNv8jqRLQvOQiTUTB+N+dY87GJkd1OKGBOQ5VbN/MTdki/PwI7nV
         HzhQm/4TZXR8LYRETVneqcnIfLVVw5oH/bfFgFCuGxhCp/bIpthuZq5dbvMfTAxFXHGQ
         bkcTjWamTeUzDTXnW/fxkJqVlBkysF/iC58kKU/xiKiGuBvJ2RJe9GDNCbR9fh6cYcos
         ZCPFwkDSikdWiP9RunnUuUeJ/P7natrqqyDta3r/xaHoRNMzOUhV/7nmOukFZtNk7aQL
         eUBw==
X-Gm-Message-State: APuU4Z/O19cQLTbYdexEn40pfMW9UDFSQDjRyf7QUHAluzJTuGE3+pQV
	ltIFdvgUbmDEJa0Zap7HcQCVp8ocRGVtz5xrzk71VDKwL7TFuUSRcrXS2ET0nfHx
X-Gm-Gg: AYBFou2CClxN6lD+8XpZmk3MpgLal3AzD8wfE1e2wDKBAkARI0rF9vKp3q8praJIXJR
	iiJ6amBO10FV8B/YO6fSPJC9ADs+Ze0hSoIqZ8/dCN181mJJctmGprgfmINN8v3bH08VyobU5ac
	QJC5Q1kFGgpwq23CImSQM313fCQP8pViozIHjpGxrlboMjkOCPccDRGwO5haeyTCZGMvQ4xH7KH
	WhVGyqb5EL7222rCPXeAzV7fZ+etAhxqwztANO1UgGRfhDqf0hTc9DTuPlGBc1K68ikQI9DCNRR
	1ht9+rRllFVeJZwHPofSwTHTA/0Sbl1K0sscXK4jSTwe4rWKlMAB6NgNOOWmgsKlv60Dqil+5w5
	iwCdBElOLRiQlCk1pFKUxQSoxCWeyiplEzrlkrK72QfI9cSIVgM2wLoCaLMmP6nic0/q0i6FeqY
	KarPtPQU5FbaLEdHHvDV0QJrSIstsuiub4nx27UmQnPK6VcIslb+fkSEPSOETEEAqfIT/0089I+
	ZE8qc1L169+i62FdM1aOw2+GhRDYphL5L9hslZt4zG7tmbczo/x+ir77T0ZeyeU9Ew2C0IDYuRI
	cYFg5R54QgzRIeQ58TARb+Lu1L55TvDg8Hpcuo022vqkVwuSWiPNDPWwYn/+Oj0F3hKGbPXX+go
	PgnTj3UXNUQFu6OCAaw==
X-Received: by 2002:a05:600c:6085:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4ba02320c8dmr51972045e9.1.1794327268945;
        Tue, 10 Nov 2026 08:14:28 -0800 (PST)
Received: from localhost.localdomain ([95.183.147.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0235ef62sm46825525e9.2.2026.11.10.08.14.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 08:14:28 -0800 (PST)
From: =?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mohsin Bashir <hmohsin@meta.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
Subject: [PATCH net v2 0/2] selftests: drv-net: ring_reconfig: handle devices without channel config
Date: Tue, 10 Nov 2026 19:14:21 +0300
Message-ID: <20261110161423.77910-1-ahmetbilalyazicioglu@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ring_reconfig.py assumes that a device which supports ring parameters
also supports changing its channels. Drivers without a get_channels op,
such as e1000e, return -EOPNOTSUPP for the channel query, and drivers
with get_channels but no set_channels, such as vmxnet3 and r8169,
return it for every channel change. The resulting NlError makes the
tests fail instead of skipping them.

On a ThinkPad T480 with an I219-V (e1000e) "ethtool -g" works while
"ethtool -l" returns "Operation not supported", and running the test
functions through the in-tree YNL library against the device shows
the three failures.

Patch 1 skips channels() on such devices and lets ringparam() continue
without the optional channel reduction, patch 2 skips
reconfig_tx_stall(). Only EOPNOTSUPP is handled; any other error still
fails, and restores are only dropped when nothing was changed. The
patches are split because the affected code came from two different
commits.

Testing: there is no remote endpoint for the T480, so the full test
was not run. With v1, the test functions were run against the real
device under ksft_run with a stub environment and all ethtool set
requests blocked: before the series all three fail, after it two are
skipped and the channel helper returns after the query. v2 was not
run on hardware; its new code is only reached after a successful
channel query, which never happens on e1000e. Drivers with
get_channels but no set_channels were not available; that part, and
devices which support changing channels, were checked against an
emulated ethtool family (unsupported query or change, other errors,
drivers rejecting only some layouts, failing restores) to check that
other errors still fail, restores still run after a change, and
behaviour with channel support is unchanged. pylint and ruff report
nothing new. Not tested: the full test with NETIF and a remote
endpoint, and the rest of ringparam() on e1000e (see the note in
patch 1 about ring size clamping).

I found this while looking for kernel tests I could validate on my
ThinkPad T480. I investigated and validated the issue on that
hardware, defined the scope of the fix, reviewed and refined the
implementation, and extended the regression tests used to validate
it.

This work was AI-assisted: OpenAI Codex helped with the initial
source analysis, and Claude Code drafted the implementation,
changelogs and test tooling. I take responsibility for the submitted
changes.

Changes in v2:
- patch 1: also handle -EOPNOTSUPP from the channel change in
  _configure_min_ring_cnt(), for drivers with get_channels but no
  set_channels (reported by the Sashiko review of v1)
- patch 1: skip channels() when every channel layout it tries is
  rejected with -EOPNOTSUPP, dropping the restore of the unchanged
  counts
- patch 2: skip reconfig_tx_stall() when enabling a second combined
  channel is rejected with -EOPNOTSUPP, dropping the restore for it
v1: https://lore.kernel.org/all/20261106150509.30458-1-ahmetbilalyazicioglu@gmail.com/

Bilal Yazıcıoğlu (2):
  selftests: drv-net: ring_reconfig: handle devices without channel
    config
  selftests: drv-net: ring_reconfig: skip tx stall test without channel
    config

 .../selftests/drivers/net/ring_reconfig.py    | 65 ++++++++++++++++---
 1 file changed, 57 insertions(+), 8 deletions(-)


base-commit: 19a227903e65c7a9c179156485660a4e017575fe
-- 
2.56.0


Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E23655D8
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 05:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791263789; cv=none; b=co78xuqwTsWjJEC8S1yreXMXKSDD+FQtNbtNaHvmrBTRP84b3IgQfb9HUrvGGEKwY9JGy1MMHcAEzg7lFrRrTsseyhqGL5Nx+50oQgjEDCMM1oEqwYOLnMxNti0BtEySNPRlgB4o/U9Keu9UbqVHGC44WdOwzL5KFMPZgHwhbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791263789; c=relaxed/simple;
	bh=r7yDJGNf3vg9Dsuvo+2fXtkz1amrdnaQFLDyMDdoBeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=by84/Y4wSF5ThRbBAFs18ceCl/VsKgeHWd84QBfaYy9h8XsdRS6pisGcyqB1coEV6whCoh9AD42A8/aR3KAONlrLtWLHrOd8wab/GIkbyxMbUY3rcDG3y+bOLJd3mcmnS4AIvu5OKEC6hD68btQst2CUzReezADJ1K3cnsX2i+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=UoKaKUJL; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="UoKaKUJL"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-82621039b6bso1225386a34.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 22:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791263787; x=1791868587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IcZAWj+F2P6v02eYEvSJlSeTa5ggyC9iZf9e6Z6vbRQ=;
        b=UoKaKUJLMoZduV6Ofexj/lX7Cze0j9UyMMCDm92Rjhm6jL2zJq4J/va7aLHeu24YAN
         MzpRtOGD+8c3TNniiYc2Hyf42JiaXDuVZtheoZo7AkIu7Nrt2NuAoFTCFc0z8Xcl0p6q
         Lp0ml28EpUnyx46Lc1ma4Liy1Dt1SKi+lEgWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791263787; x=1791868587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IcZAWj+F2P6v02eYEvSJlSeTa5ggyC9iZf9e6Z6vbRQ=;
        b=mkVmdoAVZAJ7Jm3bi2Ddl3uHMMGEfNmQBetBjS/vy+eSqIkYeLuz6kMRK07S30Rj2i
         eR5dvwD8ELpaaFTmAEP16mZ1VBDOXcyZ+eF9VoQy+cUEJST+6Td0ZEQh3hdHU+vs8vcY
         jboscsu/Oudls/5G4QT4q+bEWAs/+8UlYjtZu4bV+svVZzjfS1xxilFJZWbZPHgOa8sz
         M3dDwksBjen+eVOzTTX9maAF5JLJy37XJUSLXqHR4GyFhxIk6Zp4vzkdt0RdUjbLE1Rc
         0z5bFa80SCIhvYmBecUOaU4EWDJS9vfzG5pCPv9rl7yGoPlbyhTFpvN2P6uPf/vQWetC
         0ZZQ==
X-Gm-Message-State: AFuF++mU7JTBBzIEXaLvMrsOdu2VOLtG7Zz1NtShlYEU65YRtvBQXbZp
	Prw+tB3qe1BykvFeii9xk5nmHrFR7CBm6k+S0+N2N60yg7jtBNPj63mnuAPsq0nfpW3FCruB6fO
	vnR5gBHLjNg==
X-Gm-Gg: AYBFou1LE1cTHThf6kN7Lj7dvu1SqID6d9D7yjeXZQkwb1gojbnIC/3/bKrnvmnSstz
	/Gx3TrDIkgH2c/KqjKmJBPkqgvjfbjOpfXUb43ak8wHRMTzx2fmElIZ0XrGpbW4afxK9lclMhs8
	J2iyOZ/OGiBcfN8cIPTXCAN/4kP7//j2UjjqWFKZbzMZ/TFYmn1iEt3UAnUKqZ/5cH8y1G7yRAa
	XzzDjSSQu2ZyDREtMU9xqQgCJ27kK4xnYipyCQ1d3D1suYsI0OV/DXmXagzpvbLljPw6ZwbyhQA
	UvFnNVJ8NSj+7Rf3xXa5tldH9cRmn747XEZkR4OhlY1jfrlKsLUZ+L3+ekHGAomNoJjhU0RVAM3
	t0JG6zqhgZAlJmqoxuM5htNsScm5bxOBavcMbS9ECGE1E9AiMGUg9uf/r8wgzhjD8cTbEoQIhqb
	iUTbCgfBLZMBZBafAot1XlFzxNAG/p0fAN1JF0goK+ZJ5MVeggMlFaF8I5w+lOORodIGK1BBXP2
	RIu+EPkwrNaGufwTMKZGO5Agjk/o/g4vOuGwXadY4/0ou7Ox6Oh5C2G7bCxJArP+Gzad36maQgX
	Rdg=
X-Received: by 2002:a05:6830:2b0a:b0:805:9b28:87d7 with SMTP id 46e09a7af769-828a167af3amr262818a34.8.1791263787188;
        Mon, 05 Oct 2026 22:16:27 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8281fcce238sm1622898a34.6.2026.10.05.22.16.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 22:16:26 -0700 (PDT)
From: nramaswamy@openai.com
To: netdev@vger.kernel.org
Cc: Neil Ramaswamy <nramaswamy@openai.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 0/2] tcp: preserve RACK tracking across partial undo
Date: Mon,  5 Oct 2026 22:15:25 -0700
Message-ID: <cover.1791248202.git.nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Ramaswamy <nramaswamy@openai.com>

Partial undo can clear the TCPCB_LOST flag on segments already removed
from RACK's list, which prevents subsequent RACK loss detection, leading
to segments only being retransmitted after the RTO. Restoring them to
the RACK list as part of partial undo makes sure we can properly
reconsider them for fast retransmission in the future.

To do this, we first sort (by transmission time) the segments whose
TCPCB_LOST flag is being cleared and then linearly insert those back
into the RACK list, which is sorted by transmission time.

My investigation started from seeing repeated TCP stalls in prod and the
mitigation that seemed to prevent these stalls was limiting SO_SNDBUF to
96 KiB. It also seems like others have seen similar symptoms before [1].

[1]
https://lore.kernel.org/netdev/35A4DDAA-7E8D-43CB-A1F5-D1E46A4ED42E@gmail.com/

Changes in v2:
- Added production symptoms
- Removed the redundant TCPCB_LOST comparison
- Fixed lint/long lines

Patch 2 is unchanged.

v1:
https://lore.kernel.org/netdev/20260926002520.42955-4-nramaswamy@openai.com/

Neil Ramaswamy (2):
  tcp: restore RACK list membership when undoing loss
  selftests: net: packetdrill: test RACK after partial undo

 net/ipv4/tcp_input.c                          | 35 ++++++++++++
 ...tcp_partial_undo-restores-to-rack-list.pkt | 54 +++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_partial_undo-restores-to-rack-list.pkt


base-commit: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d
-- 
2.55.0


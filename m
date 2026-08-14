Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BC3B27E2
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735765; cv=none; b=Tk9tPB5u40DWjB6ZBdekO4cdHfTicuFuidegR27K5dCa8XxD07ihSY2kJcRt4KLiIGKEN9KEKXVwtWwgE3zIQprXPPEynTrb6CZOJL8bhmTVPlXe4QSvbLLz03UGZc5mgJuZMRb2jIydej35wIFyK54/ZZaXpJN4/U18NZG9nMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735765; c=relaxed/simple;
	bh=m5tbPv6LpSZGHmkaPFL1jRgwk6r2tud+3d5dO64aO+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bs+qOsZYrWpWVbA2DoUBcG8atppbslpOQ8TMr/hQ1dddCEOMkGo8gFkwxoLGahzKrJE9iVYLnt6Nuzk0/z/Oh+tQituKVMNY5q1DuWWK2Y6mqABifeXBPZoW6VhIALksvXxRdCvJOmBMgdcoME+KyNGFM0zbeLZmhK19DAQk774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWufDzBe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWufDzBe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957799b92fso1936255e9.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786735761; x=1787340561; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ZIulDc3FDXajLexDfl9mzhE1tVfIc5tA/5mXkm+iXc=;
        b=VWufDzBet/Y7zXutjM3zcuz3JY93uaDJu25nsLGvmZRLXiFbOotrP4H5ZpQ6NfGKwy
         YBhnVXY4HSlOsAU5d5oIvL67PX/el116GHUvuL13/kmveZerErsZiukbhCTFjDclMKBs
         A3EBQuOq89R1POnWkUWKQXnBFRSteYiqh/u4GOFGb8wgGLW8ZBoD6DmZSaJqkupNafYK
         XGtOepBztXxQiIOFxfM3a+O8OayOxWamIApU2LhjhcDDsl3n5r9BWj9LAtKjma4KVPsL
         KC8ELe7KCqpgzX1+oltoMP8rz4fRmEb3nAu5H3gYvJngDRhyOzBKcbFqEv8aXx2bLvoW
         yRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735761; x=1787340561;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5ZIulDc3FDXajLexDfl9mzhE1tVfIc5tA/5mXkm+iXc=;
        b=a4QJ7Pr8iMfLqbl85lHPkgPVralkut/EXWCxoZfs+SeAB0aAiq8EtSfdUArZyJBaR6
         GaGVuR+0HZm7l7sXjfA23VlPUYGoKW403RwgFFde5TlxWPx8x3O2hJqCEXsk5wq1YKyW
         o5nVzcg5CMSl1zCtJrvWfBAhwtX4zlycQjMOdFDRTkP2B5j8ffMQ8hjE+GZ9cJUbU0gG
         ElFw+eFbGgktPIlo5cCaBJzlHV3zMCJdrtvc1MouIXdsy/4M+DSWw0xpoNmEgBKeE7eg
         j/LRX54VObKwsVTXbpvQYPMqYlUbs8dVFeN8UbRGqxa4SCik3aTRcKuAl8hh0dFoczad
         BIAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZp9XZyn7IksIgYkfL3GckPjgTki3TpeN55LL+9YZkMyjcDaJgu/JIzLqREvBXgaJhcJWB00s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtXYrv9Abq08e9eRCrd8FtOAq+5jfssI+F1RNQC3A7ofrwfoV
	yvH81EImbkbqJlnTTNZsyZljXMfUhkTmKr9L53aJWfQsTany23fBGMIV
X-Gm-Gg: AR+sD12HTbEsPci86/b/hQMWU75d6Ut0Cv54qE+iawIMWXSJ3AWEfsHG5S2MGEJV6pd
	TH/SXDYqz2NizFmLTMsTsNsaRnEPnREQDiVEytFmv1WDDaNuWkJWgvG3hzN4CQZ7gH8MiHN80xj
	Njo6wTuIOg5IW607dJIoD6J+YI6IrvapxXQN7rAYzJ3sHpaMWUQbxnHw9uy17AlX7KRcWBtjjzN
	RfBlajvNG5imWTNeO4EZBzWbano9o8RmWPifQQlfFuCPDu+tiBPhgDAUiS3uBnp7Jqp6UdVohqi
	UvYcWV5pGOWXV0AjQa0JLMmrf/T6U6NZ0O68Wgj08SyhSc9VK3SlQ+smBWG1jZM/SYNbhYeyDbQ
	BKu3+trsKl5lm3NSglgS8yTbm2sj+gJ2n9HGFtwyyEKxajSckKn+DxR6ssATWNOYJwM/4vQJAe1
	Zz7Gr843Dna7v/ApSPPbcMgKNMEyCTLDAX8Bpg8SvQ+Yw=
X-Received: by 2002:a05:600c:8b57:b0:499:8411:9e8d with SMTP id 5b1f17b1804b1-499878cb099mr58618525e9.0.1786735760728;
        Fri, 14 Aug 2026 12:29:20 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:391e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49989ae14f7sm50624785e9.10.2026.08.14.12.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:29:20 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next v3 0/7] netconsole: validate a target's IP address
 configuration
Date: Fri, 14 Aug 2026 20:28:51 +0100
Message-Id: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Oyw6CMBBFf4V0bU0fDqWu/A9jTGkL1MgjFBsM4
 d8tdYMub+ace2dB3o7OenTOFjTa4Lzruxj4IUO6UV1tsTMxI0ZYTgQnuLOT7jt/d0PIMeRgACo
 AwSSKyjDays2p7ooiGel5Qrfvxb/Kh9XT1raxjfNTP77TcqDJSCMFgd+RQDHBVBDFoZTMKHqpW
 +WeR923qTqwnUz/PgwsytycKi0LoSSp9vK6rh9hLimOAQEAAA==
X-Change-ID: 20260730-netcons_ipv6-565d55f55729
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

This series adds two validations to the target configuration when the
user tries to enable it: first whether remote_ip was set, and second
whether local_ip and remote_ip address families match. Refuse to enable
the target if any of those validations fail.

These validations are already done for the target passed on the
command-line, so this aligns dynamic targets with the command-line
behavior.

The first two patches replace the per-target 'ipv6' flag with a
per-address 'family' field, which makes it easier to detect these error
conditions. Patches 3 and 4 implement the actual validations.

Patches 5-7 are follow-ups from previous reviews: move inet_addr from
netpoll.h into netconsole.c, show an unset address as an empty string
rather than "0.0.0.0", document local_ip auto-selection.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Changes in v3:
- Document local_ip auto-selection
- Link to v2: https://patch.msgid.link/20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com

Changes in v2:
- Show empty string in configfs for an unset IP address
- Moved inet_addr definition from netpoll.h to netconsole.c
- Moved address checks out of rtnl_lock()
- Link to v1: https://patch.msgid.link/20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com

To: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org

---
Gustavo Luiz Duarte (7):
      netconsole: add an address family to struct inet_addr
      netconsole: use the address family instead of the ipv6 flag
      netconsole: reject enabling a target with no remote IP address
      netconsole: reject a target mixing IPv4 and IPv6 addresses
      netconsole: show empty string for an unset IP address
      netconsole: move struct inet_addr into netconsole.c
      docs: netconsole: document local_ip auto-selection

 Documentation/networking/netconsole.rst |   5 ++
 drivers/net/netconsole.c                | 132 ++++++++++++++++----------------
 include/linux/netpoll.h                 |   5 --
 3 files changed, 70 insertions(+), 72 deletions(-)
---
base-commit: 4f93b12cf7b25fbf8e73d222722805b049f0a6d3
change-id: 20260730-netcons_ipv6-565d55f55729

Best regards,
--  
Gustavo Luiz Duarte <gustavold@gmail.com>


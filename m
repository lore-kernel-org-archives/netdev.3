Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D33EF64A
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965636; cv=none; b=Kv2zeAWD317YC41wr87FZG/xuYWnoZPg8RERexdDM2SmHDAaaQGW2WZhu0LY66XTJ1Y/dO+VtteX5xL8dbk/fbz+/TFtNP+FPGquRuYzLfVyvvywXIH6YxEB4EGExHxElHHa8viRLnkqNg703UONZIKovRNJP/f5bOHefeqvxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965636; c=relaxed/simple;
	bh=DO72m0tgD9qToSWZq3DvyoWHfRMOJlG+H6poJ9WLZi8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p8CjLoUvUENCCMB2Gw3u12Iy+nahj5q/v7nUvBNgxSeNZtAu5l0jaJ//ftE+GUvy24RNWxBKKESe9w6S96sNPfNK2CoM49TMBqCa3IErAhpmRx6fgtyNaJCySq0SFn6jiMsD9s+AKmXc6Fce/0S6renh/1MnJMhIM46wq2YltQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpoTUZi+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpoTUZi+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4994d41ceb9so1448405e9.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965633; x=1786570433; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xlzux255aQo2GJLhjdwu0IMLW5KJT2w/Zopkpod7j6k=;
        b=FpoTUZi+Hct+rTPMiJ+iOJJJNNRp40viK2qUDtIcHWd/bhNWX0Wqn2MBhtQs5MvGG3
         WkxA8JZgpyq5RMqkVDK327EB98ZvhEGJKeT78+/4DvYmhv0BbvmVwIcObHWOg65GHo8J
         uLnvGsCSN3DdzKczQBM/Gvq0ptQLmVPVxPKIoWG2vn0jpenMyiMRVkCB4pRXFl8JIR8C
         WYBnDfmU5azZ3LmBgZevr4t5CryfUHo0rz1s2KAxsLW8IwF6FQ9ktcZ11PYHYlWxtYJe
         CvvqM4cPYFkh4PR/R9zRKoeGuW0aEUmkUS0oSuKxFj/Qd+6pP0/mgkXkvySqcckmnGHN
         QSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965633; x=1786570433;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xlzux255aQo2GJLhjdwu0IMLW5KJT2w/Zopkpod7j6k=;
        b=XKExQcGF3+JUhlObu1bGfbHpo8JQSp9puP1oka4dAiVoXZ29xj4kyfoVBWOk1PSlXG
         7eNP3ZqAgBAYlFFBxeMdqkT0lPIkzMBgoWeRUpNCLXWpIy18V1NO3qiP3YOuzfpIqXeR
         S4lOOll+AWwR7iKBCcO9EhQtSFn2MS9l89fEmz1qZfhSK3UJ4j3aZei+PAcU/qzLENKI
         mva0iiO4sgbbxBF+eu06uVVVdoQGx1nKY1sAAYFySNVp/MIEZ2C/pUJaPAzAvFFlYHq9
         ZxZR9s6DArf4cbnmy+qiPJYPUJ5grrKDZeSKr0L1/nwOJYxXJf6zIm1o6YK5KqMOsYZq
         bByw==
X-Gm-Message-State: AOJu0YyNFw+x4THg/dTJ5ovphBdfavdgIZgTCBfybEHruhJxIgOXAYMj
	D4MrTLaQjcl6IBwFRg0HvOcRAZB3FxNdnYWYWrQJPmVMN/rJDkaIvZgNVWmkEmwqVC0=
X-Gm-Gg: AR+sD10eFyHX8xOIoda2//4zrBdfr/uHdSpDjIYUYFZVcGs/tKrnMrPgqpO2sP0Noa3
	LNTPg1g5UbS7uS7sFu0r7O+0tBB0AokaV4WIXNhbGTyrMziSJx9TsR2giJ1guUyWVz3yK3GEjMX
	OWC8VUjnngh7ZghKXyz0I7bhuzqgI/GoR9PVx959pavSs2y8Tej1ZvG7kBfsJasMi2erwv+UPE9
	mwDAGKnQB+Ur6i8I0rUjE5AF2RqyRJKevkz2AQl3b4lwSzkH5YdwLA3KxXZJCyVQQ1PzwNL185+
	DXtDVhWCVcOs0F0Ft2Z4lnHi2CHuAsw0pL+jmT4mL9fhKVaCAucMAsxCMmnNchdGdHQebiIBFsJ
	MUOeGDtlWDHdxvajxGUHTO43v96f+s816ESm4jn6v1TD6lfoELBap18osnhpVQaDrf40f/1K8w8
	drLRYwblE/fVtk8eq1XrR3gdddrwnXR/hUgWiAaHkuHo8=
X-Received: by 2002:a05:6000:4006:b0:47f:7c3c:aa0c with SMTP id ffacd0b85a97d-47fec523a80mr8529042f8f.3.1785965632768;
        Wed, 05 Aug 2026 14:33:52 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:f900])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b1809csm425096f8f.18.2026.08.05.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:33:52 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next 0/4] netconsole: validate a target's IP address
 configuration
Date: Wed, 05 Aug 2026 22:33:00 +0100
Message-Id: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6Xss4EYuRT9FRGx6VXPh7TkYimU/
 ntPfRx2dlYoF2HFpVlReBaVMRscDw3S65Gf7KQ3RvAh+vbkXeaaxqx3meboKFJPNBC14Qy7TIU
 HWX65K8w0e6m4/Rf9dG9O9VvDtu1PkRBvegAAAA==
X-Change-ID: 20260730-netcons_ipv6-565d55f55729
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
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

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Gustavo Luiz Duarte (4):
      netconsole: add an address family to struct inet_addr
      netconsole: use the address family instead of the ipv6 flag
      netconsole: reject enabling a target with no remote IP address
      netconsole: reject a target mixing IPv4 and IPv6 addresses

 drivers/net/netconsole.c | 117 ++++++++++++++++++++---------------------------
 include/linux/netpoll.h  |  10 ++--
 2 files changed, 57 insertions(+), 70 deletions(-)
---
base-commit: a23b36233d4103def55dc8cf65698106d0bd1e62
change-id: 20260730-netcons_ipv6-565d55f55729

Best regards,
--  
Gustavo Luiz Duarte <gustavold@gmail.com>


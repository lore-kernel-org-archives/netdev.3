Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6B375F65
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485658; cv=none; b=Ks53jcOaHkzyaAWB46SHYrI0WgVZQgTvv1m5buR93CRX2pe/+NRYRc65O314B/IGMa4Xy8loQWGdj4SqwlNgJNz06E/BiyDc7gdk58f7Nq/AnH3fI1EJL5HfJ+BTvoxAaKUQ8QL7AVvJV0oAszNrrixUqSjchh0l2YJfjd7r0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485658; c=relaxed/simple;
	bh=o78dihvCR4QZ4C3mta/CvUdV7mYAuNVF1FtlYFhOjm4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KNUgPw/YXitqcIv1hvO1RorsdMLrWm5uZZJqmbqyxhbneBztlc329GDH2dYo+DB1V+j8eO9EcrSW1xMZ2xSp6AIEhouafps88R7H0zqmsdouxr6pU5IP9cDKV6/jhEH56V7pWPLVQXfb5OmeP16YbMUS7w0SEWWY5xXKxBUEcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPT86kYB; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPT86kYB"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b333de9451so491694b6e.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 18:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788485656; x=1789090456; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gmQ5igFexm4sUQOCZXQ5PKCRuhBD2HGUSJLv3v9h5RA=;
        b=FPT86kYBCtfQWn/n/uWSGsQtw3LHcblK3tdzd6+pUE3fvneQmjrKXZAAaXvJJQjJXP
         rmR1G6kOWJnOFywJVfZArxCC1K/wyVUpMJrcZrk/rsVPYhTUNHiB6VKtaHQCa57/UF34
         vvLdX2JH2BfSc6qM/HuZkKc1KTzbYikqg2YgoE9c616Lu9GlXE8qSfKYGx5SYKQqjexj
         ks8qQPZTExcIuVpHtB2Pu4PpN951LJLiDuASEObpNSBFVgaAV8ee2QYqjVLuw+2RuWyO
         eh/Mv3OeQn5JYB9Sq3Eek1RltOviOdfCvWTRptrpOCx89Ps0K+4txdhLsNanak2jsepX
         ItEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788485656; x=1789090456;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gmQ5igFexm4sUQOCZXQ5PKCRuhBD2HGUSJLv3v9h5RA=;
        b=j7/uq1ue5vWpQjWYcH/0R0p4LJ/kVqvm1nOe3/xjBwBoxitC6QXAOGidt5IrexZnvz
         FXBa13w7uvOGmLy1BKrhlMwsFZ7gIzhv3IHvv8AWLKVm4AGHgAJQWL1vXEywy6mywt4W
         5sXNvIZ2YtiTgdYOGs/+AN7SbKy4V6AVQp4ZiPQ4nlfR8psOrH3MjH6w3dLeq+xTB6Bo
         aUqbTbeyg4IJGPViMYI8il248Wac/YtMNs5W++U1H1CdnvP0ES8lOahdzFC/s7Wt2YdX
         S2fke4CGUKHNKWYzjKONaGp15aRfAgIMrKXN/0xobemfUNbNSuc+9IHnxK7iJ1gQEQr7
         gOvQ==
X-Gm-Message-State: AFuF++ng4c6wKGYjqvqEH7dJJHOiCa50zwO0IDFsfAb1lu86sfbnodKc
	5BHQw8/k6iaNdHIvQAYMUMYjbbcvqf3pGEX5n+sL+e78ZvUJb8PbNfC7Ynle5sDg
X-Gm-Gg: AYBFou1BZy3HsmGW0wy7e9zUf6H/Qsth4ZS6KqYCOB/B/dOlz5fgZH1NtrjaquZUl3m
	8M8eU7kMpDObu3Wt9F/Mr3gXMY49ZuifkPZHwLfh9nEq1bjRuUHDs0Emx0l56VPS9nS2oFfd5JU
	z2LkcAl12DBcNS6zCefKh55nygG9JkSvNmLh1lKS26l6gadhCMuBOg4U4GtfI9It3S2A4xYh/S2
	sVwavCxjih5fSnCj+OXDYqVTD1YkBHDGhwIxKMI1wrAbqQ0vSiLHSAnSzsM/HObMxVYbg6iX36Z
	ngG8iR7q+K8KBY6sxVcrK0VWNsdCgUQAX3gOMhUuhckJeF/QIkvSRaj/MM4sXPuI0mlpKrFerPN
	sK1P4rp3dTz10Qt1nHZlQ1zdNV92OBWnHlYvKoX0BVg4k3V2wLQZMOMubFEzkgeFW/CTtDyA9Cr
	dYlI8r8WV5o6gXrOS8MIsRz9X+0DPweI3XmyYBVH+VfcnKsqQ0L3JoZWvg
X-Received: by 2002:a05:6808:1404:b0:4b3:7fa3:890b with SMTP id 5614622812f47-4b95fb4f409mr2553182b6e.2.1788485656136;
        Thu, 03 Sep 2026 18:34:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971b97c72sm1056170b6e.15.2026.09.03.18.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 18:34:15 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next 0/4] psp: make tx key ops optional for drivers
Date: Thu, 03 Sep 2026 18:33:58 -0700
Message-Id: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAYgmmoC/x2MSwqAMBDFriKzdmD8INWriAs/T51NLa1IQXp3i
 8uEkJcCvCLQULzk8WjQy2aoyoLWc7YHWLfMVEvdSS8Nu+DYeTg2a7cI2koMesp5lrvGfzWSxc0
 W8aYppQ/Ee41NZAAAAA==
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

This is the first of two series which together implement rekeying PSP
protected tcp connections. Here are both series together on github:
https://github.com/danieldzahka/linux/commits/psp-rekey-split/

This first series is mostly non-functional changes, except for the minor
difference that netdevsim driver implements tx key ops. Its tx key ops
were basically NOPs, and in the future PSP core can subsume the assoc
counting that it was doing.

The purpose of the refactors is to make code reusable from paths that
will be added to the code in the rekeying series.

Patch 1 exists to setup two paths for tx key deletion, one where keys
are deleted as they are now in psp_assoc_free() when the assoc refcount
drops to 0, and a different path in series two, where the keys will get
put onto a queue for deferred deletion.

Patch 2 exists to allow tx assoc state to be set either from the
connection setup path, or in series two, from a tx rekeying path.

Patch 3 makes implementing tx_key_add and tx_key_del optional for
drivers. These callbacks only make sense for devices that utilize a tx
SADB. This distinction is important once rekeying is involved, because
an SADB implies a race between in flight tx packets and key deletion,
that does not exist for non-SADB implementations.

Patch 4 removes the unnecessary tx key ops in netdevsim.

No new tests are added to this series. There is no real user visible
change of behavior.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (4):
      psp: refactor psp_dev_tx_key_del()
      psp: move code from psp_sock_assoc_set_tx() into helper functions
      psp: allow drivers to omit tx key add/del ops
      netdevsim: psp: drop tx key ops

 drivers/net/netdevsim/netdevsim.h |   1 -
 drivers/net/netdevsim/psp.c       |  33 -----------
 include/net/psp/functions.h       |   5 --
 include/net/psp/types.h           |   4 ++
 net/psp/psp.h                     |  12 ++++
 net/psp/psp_main.c                |  13 +++--
 net/psp/psp_sock.c                | 115 ++++++++++++++++++++++++--------------
 7 files changed, 97 insertions(+), 86 deletions(-)
---
base-commit: 6ebcf5074cff0402730c6981d2397139fee6322d
change-id: 20260903-psp-prep-8c6b0e4108e9

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


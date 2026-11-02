Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661171;
	b=V7EZYKQbNXiExH5MwQA0kEaAkAcKv1HI6Nc1mAqc5brJdcKhP9H6MyFP5V412vVWfu7w
	 v3+lqCJI8CbA0iLfWr6wSMvhUX4BxPqGNdggb5CEI36tara6XE3fAEthIKtwWusB6TdUt
	 7luMvlqwP+ku1NSeulV7MgVa5LrSTCL8Mlp5NwVE1AjW3YBRB6p4qEAUFazQUGkVg9IDJ
	 Aalq6ofiDeHS532GtBbXqFERoMXPulREM3nsgCzq1BswB3FE1PcLDOkCTwe3oRyY5BbB/
	 6Nzm7ys37o9UNw7L+jvM5WbgSGb6PoSHMnpYml2POJCRm3uipoyL7PgTr97bOmQ56WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=EamzdbmCJd/tsLqc1Uf5xYkgzwxHOHLxwnt7C9IRutQ=;
	b=A2hx3fgPonYLnYU2LyvGU1k+56gkpgSNzUD9riIu7pl0VKoBXpfF8PRTBIyJYvnxQuRC
	 xaqnKUWAwYOaX/bo0MZxPCLskMfZnaRWK7TLxf1E8Yl2ntDRarJWakIe0x/KSTXN1Xduz
	 PWXEfklbKkWPzr3L3JO2VEN4p7OqmeueYRPmsbX7QifNDwMrYmsHI17MK/YL6CLDVm2Ji
	 WgWsmfdCkw+U0x0MzzPP9YC8jWTImOVt2NzIQ0t7lV0nFjo+Cwsa2Tlh0OxpRJehvMAUc
	 HsUF41D5Gx8EOAc/JyBA6zh7h8qZnSstWv/0byCqD6rz2j+xCl40akbXMcli4KXJCfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="rx8b/Fy+";
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED07606A32E
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED07606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rx8b/Fy+
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-679334baa1fso3871159d50.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1793661170; x=1794265970; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EamzdbmCJd/tsLqc1Uf5xYkgzwxHOHLxwnt7C9IRutQ=;
        b=rx8b/Fy+NjWKy9Kt9BkYBTAgAdfsrCjtSJw8M4hgKdPwSbdNWSPDWS+qzcv7PpS2X0
         5GpXVRoxUaZ06rvZROEMQEK8Mttmw9rGPzF93KOiP9W3KhIAYixd7e7GNOgC4Fr334R+
         ZMd7FukI1GTj1DTuhU9+GULRf5Xbb/LNWXhyf+MMw2FwhCJ82Zi4Ko0jgs9VZCKtAS5x
         oaNuyuW9O/UX3/pzgRC6JwSMVmrAnNCPfmYE8DdZzfw6boqxFs9vrYo7Ge/Mx04wtHt3
         oH7W5UO7A+o2/swON24J9mUTxAOGRp+JLyPEKuWH7Od/aF95WucAzIhYr4/n/eokeaGH
         ubDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661170; x=1794265970;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EamzdbmCJd/tsLqc1Uf5xYkgzwxHOHLxwnt7C9IRutQ=;
        b=QR9fSl4pxcFSvtA1K66j7rrhAxE85Q8076pRoJQ2Xk1CWO/Nlsnc+cqjdS6gQHU6Rw
         DEQivuus5zmasZC8k2WQSdk85ewWmbPu/VBH5lqcYStC1YqDzmBVY2QkU3K9VNVyTpYy
         mAGP2ejiFYoLAz1o/RQ/1GR60AyzxOBZlEVjWj08c2v/mDtQ4d7pEuxPpbS9C3zjS2my
         S50Zeu1fVEaHmM9VvvJx4FLqiSTE/cXIvLAN4DaPFxyQhzert1UqIsZJwgSdwiy3C9br
         HMIEnavSLHWmmd/tJrfAJ1GWI09JJ99yTFw3Vkw0DDG/aVdh+i7YCAJZJfrHOOEfaYQB
         +DWw==
X-Gm-Message-State: APuU4Z8CfUAnwvWEfmaWHjWsLuY+CVW9y8wwOWYEWjL3ZiPJwyCnalee
	RikZYL/HGZwJllkjYn3Hsu5yCTcaqFeMTAysJ0IeTURO16PDAidgjebhJo0nuxn2bkBl
X-Gm-Gg: AYBFou0QKpqOpZMZGRbrUgCrp4rpHrSDDvAgIyVl10aEPlGblV11FknMH+UlVFdbkrb
	h9wEQmZWQSVq0g/Deje63H5Zhi93QXImJ6C9Gzd0jCaDd3Gd6MY5BWIau6lmfv5JYcJCnhFiA4D
	LeuDTjCFjrOjEiPEdS+6a3bVVE4dRZIWEzUFKCfTd5MXMx2ssixlLX6YNT0X6nQjCnToHEneUBA
	572za9AycnAQC2JE+sp/Wd1OsLl3eUDLegtKhG+4USp/0NERskyc2GEqJBfQ0JlzPTfFLNOOOiH
	ovhLZc/m5rY1smFSLcjHCCE3YOtvSoLsE2IvkeOL9NoNKfL0uolbKAtJWXIo8eFzcVOTtbZ+Dvl
	Qkq70iMRrHwQriiaVsYOJMjCmr81wc8YTvqv+64ZEonMb2Qz5M5EBPQuXOzfng1uNs/d8ACu0Rq
	JwVvC1ht0WwrKMlAyqsaFzACFdeCwwq049U1qaqU+m/vlQkhdHM0NwLtQ6GS1yRhECG1Bpb3/Wl
	Y20zUQcUt+j8s1ltIyoc3PKXlvwUFDr2GT5Awak4kgKWuXWLhtCamakiYDkY6E5TMD+bKq0pI63
	Bmo2R+6q85fu/cZUjIY/azlYdmztCdBHdkLR7EOMl/vOE1gKfFf7Hya0da6ZEWnboPlcYp1KN2P
	XdV9lKytMgMdKVIBsXWc+yTpenq7saCY=
X-Received: by 2002:a05:690e:1094:10b0:66f:c1bc:408f with SMTP id 956f58d0204a3-67ba50187demr4711928d50.82.1793661169876;
        Mon, 02 Nov 2026 15:12:49 -0800 (PST)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf3303ebsm5946481d50.18.2026.11.02.15.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:12:49 -0800 (PST)
From: Andrew Halaney <andrew@amutable.com>
Subject: [PATCH net-next 0/3] net: add SO_PASSCRED_THREAD to get a
 thread-specific SCM_CREDENTIALS
Date: Mon, 02 Nov 2026 17:12:33 -0600
Message-Id: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQrCMAyA4VcZORtoC27DVxEPJc1sQKMkRSZj7
 76y43f4/w2cTdjhNmxg/BOXj3bEywBUsz4ZpXRDCmmMISas+ZWV/+j0RjIujq0a54JTnMI4h2W
 mK0HPv8aLrOf6DsoNldcGj30/AKCaSmZ0AAAA
X-Change-ID: 20261012-halaney-scm-creds-thread-7170680f8c5c
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>, 
 Willem de Bruijn <willemb@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
 Andrew Halaney <andrew@amutable.com>
X-Mailer: b4 0.14.3

Currently, SCM_CREDENTIALS carries the pid of the thread-group leader,
despite carrying the uid/gid of the actual sending thread.
SO_PASSPIDFD_THREAD lets a receiver identify the sending thread, but
only through a pidfd. If you just want to know what the tid of the
sending thread is you have to do something like:

    1. Setup SO_PASSPIDFD_THREAD on the socket
    2. ioctl(thread_pidfd, PIDFD_GET_INFO) per message
    3. close(thread_pidfd) per message

For example systemd-journald wants to log the tid as "trusted field"
(aka provided by the kernel) but doesn't have a great way to do so
right now, unlike the options for uid/gid/pid which are covered by
SO_PASSCRED currently.

So add SO_PASSCRED_THREAD as a sibling of SO_PASSCRED. It delivers
SCM_CREDENTIALS_THREAD whose ucred carries the tid of the sending
thread instead of the thread-group leader. This is completely
independent of SO_PASSCRED, so a receiver can ask for both. Use
a new cmsg rather than changing SCM_CREDENTIALS because users
expect ucred.pid in that context to be the thread-group leader.

As with SO_PASSPIDFD_THREAD, recvmsg() on SOCK_STREAM sockets stops
merging data at a thread boundary once SO_PASSCRED_THREAD is set.

Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
Andrew Halaney (3):
      selftests/net: pass socket options to the scm_pidfd test flows
      net: add SO_PASSCRED_THREAD to get a thread-specific SCM_CREDENTIALS
      selftests/net: Add tests for SO_PASSCRED_THREAD

 arch/alpha/include/uapi/asm/socket.h            |   2 +
 arch/mips/include/uapi/asm/socket.h             |   2 +
 arch/parisc/include/uapi/asm/socket.h           |   2 +
 arch/sparc/include/uapi/asm/socket.h            |   2 +
 include/linux/socket.h                          |   1 +
 include/net/sock.h                              |   4 +-
 include/uapi/asm-generic/socket.h               |   2 +
 net/core/scm.c                                  |  32 ++--
 net/core/sock.c                                 |  14 ++
 net/unix/af_unix.c                              |   6 +-
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 229 ++++++++++++++++++++----
 11 files changed, 242 insertions(+), 54 deletions(-)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261012-halaney-scm-creds-thread-7170680f8c5c

Best regards,
-- 
Andrew Halaney <andrew@amutable.com>


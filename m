Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037449C4AB
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911123; cv=none; b=h5fYMgEhQiLBwTmFOrrhlVFYAWrbqJ26on95dDec2tv/vwKnhUjaUJmah9gAJut4I/8V/tMpBuiO038R9bzUTLBkZBLkkgOGEH5eP1svXpxfIMMmvWzz3lmO9anjtPZ5YwafB3COpg3UdcYyyWqD2YnQoKJGlUR9AZNcnEW29Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911123; c=relaxed/simple;
	bh=UNHyV5Vp2KGWRl3CC0o5xYWyjuskR4xDHkSn9B/vuNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCxYPExb8SGmTXCqxqpeqzt59+qEJ0iJ8uSgKfMWda4qLbFOKwR19TE1rFWf2NXixFtuImczrJNOqEofRagmTWgfYeDV6RVFRlai1CVOtyDdbGD6ZOo82YyCxbGNm68/VrrYsOSCos88A0Y45wu4fW0PeeQOFyjQqa3Fd0vpBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/wSnJDq; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/wSnJDq"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9104956083aso40609346d6.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788911121; x=1789515921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HOpcOU9vheynx/fQ+9xFXI+Vv0lGzJ7j1NxiFmEU3PU=;
        b=H/wSnJDqIDu9xA+aumqQ8Fz7nrkXyMM/weEBnGM54W7yWWvKQyJMk39MSDmkqTz7n2
         o8aR4+bcjhGjXdCBMYBheAEtUfsM/UTe6VNZjfSBWImT6VIQjql8/IRJIZw3jh3W4n+Y
         lYJDEBm9ouj5D68MjBlUtgVuA73Em1FUK1b6voRrk+LiAd0sN7Zk0XK2CkFWPCE1eKrb
         BnFi20hDMowcJi7tjuwnwc66xddt54mHBtQkq65VOPYXA9p7wtce5hgj9EQtdj7gukmW
         ZVso8Gc7GIHrHX4fRWETmaq+fb7Glo33t5Vkhy0Ld/UgPzXA7UlSESHiNb7hYVo3BU9x
         ECJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788911121; x=1789515921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HOpcOU9vheynx/fQ+9xFXI+Vv0lGzJ7j1NxiFmEU3PU=;
        b=KcH/JhW2Kd1FDPrVTZu6KbNMyVlHj594vNJ6fORrK1nrrb70lGceJe/EIo7mB0WCX8
         9oejFiPlJxq4rD1AYSx/QxWO9pPPefW0JMTdhb6Dc3Ju6uNNH9RQhLkT19CAL4msQn5R
         e8byzyPdPZZiXMTc2RvSIu8A3D/LKi1v+Gm5a7Lg6aZkrlb5FUxHifvhvPMd3y9WSI4m
         KcLMQoQSFT0/Ikm5XNBYUqXlP+GnT7WYEdvvoNiWJbMPs6cA3fez9tWOlhT6NO39HDqG
         q6iKD5Jb2c4W8SoVyUgCOlG/14FJ8MklqxIkIQhr89TRVl4xr4JkVJvVzUkntWMAZaVn
         0Ysw==
X-Gm-Message-State: AFuF++m8C9IkbWy1W9l/WbvCjljux1Eaxs3815IdXaMyWVvexLTqmVV4
	FfQhl2qgXda9m+lAABgfSbdxFCN6RRcTxGJVweSq+8v8tbsDEKFwwX8Z
X-Gm-Gg: AYBFou2XBbJ4PA7V7imP3Qv7+/UyEcJFvDtEdz9f0dWdk0xyINEZpezBy3QZvShXsCo
	vQT/1kaB41zmZMZKrwFX4wDHgV4+5TDKNFhb/hcTSzPWElu4ht+jf6edudTpPL3ePIyYF4D12oa
	PhnOLr3K8lSAMJJAOqiJAVQKTDR8jDcwEfLCGPtM/KoUzogkCbX0xiIcgFs2xxmQgEis3pn45+k
	5rz8qU6nNZOywRTVDeEWXapJNcDbcgLhoPxCoDjHcInG2jQcOLUWle1MZXyvJO6URHqrjjqMcR7
	IStbt/xUdLpLKr62vGLteIyY1kfWGi7EkhrkLNe0PyzfGKA9eEXtGl+GRyRNp+JOyHfa2WPxSmD
	Vh9ZLFp85turSWuVuOsHqcIj5IuYJDINVfgwUaqJ21/QTaW09FwcOo6iY8OMgIhZfzlEJ9s85VN
	fb+gvJj+BKZDYmaNyAP57cVpKJLRKMdCUFRK+Dxa90FzgSnfMz77r7+1YXI7aw3LB0P8O2U7gW2
	YXW6yqV5oQ=
X-Received: by 2002:a05:620a:c0e:b0:939:1acd:7d9 with SMTP id af79cd13be357-939802f7bbdmr2380037685a.4.1788911120570;
        Tue, 08 Sep 2026 16:45:20 -0700 (PDT)
Received: from elster.cvl.swallow.glass ([2606:8e80:692f:3320:980c:c29f:b4b9:c06a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939aff54ae0sm551872585a.8.2026.09.08.16.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:45:20 -0700 (PDT)
From: Taylor Bates <tmbates12@gmail.com>
Date: Tue, 08 Sep 2026 19:45:09 -0400
Subject: [PATCH net-next 3/4] tools: ynl: stop find_kernel_root() spinning
 at the filesystem root
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ynl-robustness-v1-3-f255214c0f30@gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
In-Reply-To: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Taylor Bates <tmbates12@gmail.com>
X-Mailer: b4 0.15.2

In the current pyynl tooling, the find_kernel_root() function
contains a loop that climbs up the directory tree relative to the
spec file until it finds a MAINTAINERS file. If ynl_gen_c.py is run
in-tree it terminates properly in the root of the kernel tree.

The relative directory returned is then used to build the provenance
comment. The path of the root directory that it terminates at is
thrown away immediately at the call site:

  _, spec_kernel = find_kernel_root(args.spec)

However, if it is run out-of-tree and does not find a MAINTAINERS
file in any of the directories, find_kernel_root() reaches "/".
Since os.path.dirname() is idempotent at "/", the while True: has no
exit.

This can be reproduced on today's tree if the specs are copied to
a directory outside of the kernel tree:

  mkdir -p /tmp/ynl-oot/specs
  cp Documentation/netlink/netlink-raw.yaml /tmp/ynl-oot/
  cp Documentation/netlink/specs/rt-link.yaml /tmp/ynl-oot/specs/
  tools/net/ynl/pyynl/ynl_gen_c.py --spec /tmp/ynl-oot/specs/rt-link.yaml \
      --mode uapi --header

The fallback implemented in this patch still
provides a usable output:

  /* Do not edit directly, auto-generated from: */
  /*	tmp/ynl-oot/specs/rt-link.yaml */

Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
Signed-off-by: Taylor Bates <tmbates12@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2b3483db1b60..1c422141d2d7 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3449,7 +3449,12 @@ def find_kernel_root(full_path):
     sub_path = ''
     while True:
         sub_path = os.path.join(os.path.basename(full_path), sub_path)
-        full_path = os.path.dirname(full_path)
+        parent = os.path.dirname(full_path)
+        if parent == full_path:
+            # Reached the filesystem root without finding a kernel tree, fall
+            # back to the path given.
+            return None, sub_path[:-1]
+        full_path = parent
         maintainers = os.path.join(full_path, "MAINTAINERS")
         if os.path.exists(maintainers):
             return full_path, sub_path[:-1]

-- 
2.55.0


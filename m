Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0C49A3C4
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823341; cv=none; b=nLD8hhxq2sauFrW78Aex4sJsrerYYjm9kfW7BCNZ76e7/Z96Dp21nziQJY2slSNF65iX3c5hwStl0vaqHvSVQ1lBZSfBMITVEHmI78rtLQEL/VTMUNqbXQhfnCOpJy5HVWasml80HuJcES+dTcV4Ci9HHFfNmY2qyXzTL8sYY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823341; c=relaxed/simple;
	bh=jU9YbQ0C3YKV2XEkj/7k40D2iZWWWqZ4cayqa/1EoZ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g1aHBsYRCevelhqkFefq0PGXQsTS0fxDyqWevRJMjZ5z/2tiVpoHIYTdMl6ODCn5B3SYV1rRlqg6dmLIwZ+euUpMc5ZjYNVnA3QyLnL+z+aRgYvlvQsLlbCJVmd7uBr8ztGWoBqBPIOQvx92cj+jukE8zWyHh/TNXrUJx1sbk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0xQp4t7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0xQp4t7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a005aa0838so1954945e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791823338; x=1792428138; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=phG25fvm5Pm8WgcnkqOyHfa1Z+6AB0mZDmvvu8mo0IM=;
        b=n0xQp4t7mBYU0NoJj0u2BeoMxpn1kpzPeyQq4SHvsNPy3JqoxEvUAqgNj3FK77gUdA
         t3lXfuiVzXt77VHqb8j7YC5SnOGN7XtPy+ntG6Q5WoEaePNjtFtYudj82CniFkukgVmS
         IlKpPq1jXEBS0WGyCXEctYg8gQCuWjNv4a7Hv4Acq85wPa2D8sXjqSK5JM5Z/pcWIVsk
         o7uQh8uF/v7uxFRlm+YCKVHyYsW4q4O5FvAHFSWdMYD8gm57pWeyCeisCPxgH+7PFVfO
         1tWeSN7OkVuWgVKksSOy4IgVzspTDTC8WAdxTaaRxUu6dlEkOvz+wm+3Y4QS8qHNsYS+
         1Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823338; x=1792428138;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=phG25fvm5Pm8WgcnkqOyHfa1Z+6AB0mZDmvvu8mo0IM=;
        b=AoauhAWT/+UpggrFGLMyuGbpuBu5A1S9efO+WL1dgI67kQtwZDLDGurlgZsMQ9c0Rs
         UjdCQ1NK9q0TuTRM70Tgus7qgCDlccokZ6uYViqbSgU5prktrFgO3TSmGFBc8FbwKZOK
         m66EQJ49p89iW3UcXtzNKkFMdm8g/L2KVR98LIZBOP9erE9GgXC1bismmu+sUbHZ0jMD
         3J+SgpuwN8fJMrKFsd3twZdtcRhIDOkg3+SdKO9bOtjDGeCpliipPup9LScq5sz1JPxY
         x6PglM6V054Ao3sXgZnrr3tiy7DLWNADYCwcXFUCtcuyLq+U4D71CwispEERC9YVlEaD
         Thdw==
X-Forwarded-Encrypted: i=1; AKwUvBziL0gRtA3CQbrLxwVBWGHBYmo+9tCXwNygXkXuBJ+vhH21Qm0xsBKNgOlCas2CXSKs8St6ZWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgYY63vTNwUrLe29MskQlNDvzg4rg+F8GxwgGTT9mrNq0pIXfU
	rzSW4SjIwm82JceD0bUGUlVYygrVHqhIfVbfS2COHVGTXBELzYeqU/dm
X-Gm-Gg: AYBFou00ASP9t1P8FdndVF5EUaPy79PIQVGqnuR8cla+dPMqAPkoR5ZUxLHKdip5Hs2
	qui7GCYOR9o6ZNT8GtGDE8rfKkb9S23OWacWsSWDWk2xIY8ZAmiZV+O3joOgYQqakHsM8MgNB6S
	PSt+T5Q4hd0cluTsvNiO83idLNOHj36+D55M0b3Fslm68vjTtoG2B6hpnJok1Rkk4UQio3vpeo1
	8IZ8zntcyhRM93pMQHuNcMWHMbJP9nYAtCiXKuxzVdRGwC6D5/SY/lJoghCvbsPkkTuTkFVgLz+
	CZNMsPtQZcpNmymp3HJzjsmSzZRrHdAZQHGnPqcdYncUtQ8/OtVKmVXNjb0azu35aeRbJxA74pA
	Ub0WafYIrrl0tJ51XHx/Pd++FOXES5b9rwSRz0cZgUP1jPy6s8t1oFiw6VdJpRpvFvUIuUfDb6U
	dmfZK6gNyJ/aVGk/PSL5e04vaPc3B+noQwFirPwsIF2jfO5AXoJAon
X-Received: by 2002:a05:600c:1e0f:b0:4a1:8469:e6c8 with SMTP id 5b1f17b1804b1-4a18e46f48fmr180323865e9.1.1791823337763;
        Mon, 12 Oct 2026 09:42:17 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:c555])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm466647905e9.8.2026.10.12.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:42:17 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net v3 0/2] netconsole: fix target enable race and configfs
 read locking
Date: Mon, 12 Oct 2026 17:41:56 +0100
Message-Id: <20261012-netcons-fixes-v3-0-1aac85ed7665@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw7CIBBFf6VhLYZHIa0r/8O4ADq0GC0GKtE0/
 XcpGhO7vDPn3DujCMFBRIdqRgGSi86POfBdhcygxh6w63JGjDBJWibwCJPxY8TWPSHilisOtOZ
 MaoGycw9QHlk5oYyi8+cYH/oCZlqbVmxwcfLhVVYTLfB3oNkMJIoJ1lpYCwJk26hjf1Puujf+V
 roT+9mUELm1WbaNkoJ1Qtiu/rOXZXkDwmhShP8AAAA=
X-Change-ID: 20260925-netcons-fixes-93a3e14326b5
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

While looking into the sashiko report about local_ip_show() and
remote_ip_show() missing proper locking [1], I noticed a couple other
places that need locking: patch 1/2 fixes a null-ptr-deref when enabling
a target races against a NETDEV_UNREGISTER event, and patch 2/2 fixes a
use-after-free when the local_mac_show() callback races against a
NETDEV_UNREGISTER event.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Changes in v3:
- Use target_list_lock instead of RTNL in local_mac_show.
- Link to v2: https://patch.msgid.link/20261006-netcons-fixes-v2-0-ca652d55fd4a@gmail.com

Changes in v2:
- Resending for the 'net' tree.
- Link to v1: https://patch.msgid.link/20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com

To: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Gustavo Luiz Duarte (2):
      netconsole: finish enabling the target before releasing RTNL
      netconsole: read np.dev under target_list_lock in local_mac_show()

 drivers/net/netconsole.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)
---
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
change-id: 20260925-netcons-fixes-93a3e14326b5

Best regards,
--  
Gustavo Luiz Duarte <gustavold@gmail.com>


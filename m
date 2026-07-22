Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645503E49ED;
	Wed, 22 Jul 2026 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691712; cv=none; b=i1RDxNtHMeFvh1ilQCYCcoWEqvR+aXN2JMZwFdrczqWEYVKwDaMxfBBHVMXCMhDylcOieN7dlCGOho+lKmBxjLiC1WchE+tmzjeKRekZkLjtMfefEuRuqcbd+tlv8GEP2Tej4C28v1va0/eUnYHtzH4La1p0wrN86etuzjt/Nls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691712; c=relaxed/simple;
	bh=wFc01ky0wiC8TSKnf9eWcxVo+r/O03nRq6huFbYF7mw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z4X+dBZOqja7QUOz/W/ioxSdEAGhF7DcB+JE2cXawKqQJh0gDhMLLrnk9kMSF1EoefSsqc5YGgeTdm2t2X74QkiYjWLbXx82XqWF75YMDvxl5jP4RgTF0pdcUE7JUMzPIfrP9kldoXVThlPQr30brHjGK/WMwOQUltlplyogtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=snBQADMl; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="snBQADMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1784691708; x=1816227708;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=TB0Hvn5ONW8G0Wja7XMN/KwjPVP6Ai1KndzicZDnOgQ=;
  b=snBQADMl7ZAGnaImHY5FzWjLXqXdjPp2Ms0J710PrdLH+EQ+TJMJlvth
   Kb+zvZGbfLrJNpA5Tg5kDQ8TSsotsm3fkFYNbrS9rqn6buBRfJUKHxnZ5
   CxIiVegeR9E2hIyiBdlWR6/O4BhAstOxPpvLDZmzboDmeB5tUjkUeEVl+
   KMowI5+kKUTYRpIVsdXrxVDDk7utoRBeqJ0yS/U29fVwx7Ln3eW33OXxn
   988K4YP7ECREbhd4+9tKLhcfybJCejt5IluoW3cGU3DhZ1u1K+lS1cRxd
   YUs+E/Za3PLat9NSckr7fzkbiufIjcTUpMLer9AcVKKGLRxskkXMRrAMF
   Q==;
X-CSE-ConnectionGUID: qYD/RAJWSjOmXXIRyhrsOQ==
X-CSE-MsgGUID: PINgkoPGRUO1+hVlv3cvNw==
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Jul 2026 12:31:37 +0900
X-CSE-ConnectionGUID: me/Eo/F5TzCEp2AisWN2Fw==
X-CSE-MsgGUID: rOfehimtQqWz7B+ZeRWvgg==
X-IronPort-AV: E=Sophos;i="6.25,177,1779116400"; 
   d="scan'208";a="627327270"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 22 Jul 2026 12:31:37 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Subject: [PATCH 0/4] usb: enable sysfs module symlink for more built-in
 drivers
Date: Wed, 22 Jul 2026 12:31:20 +0900
Message-Id: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIg5YGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMj3dz8lPi8xNzU+NLiJN1U46TENFOLVEMgVAJqKShKTcusABsXHQv
 hF5cmZaUml4DMUKqtBQDfksW3cAAAAA==
X-Change-ID: 20260722-mod_name_usb-e3baf58e1e1e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bastien Nocera <hadess@hadess.net>, Matthias Kaehlcke <mka@chromium.org>, 
 Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel.palmer@sony.com>, 
 Rahul Bukte <rahul.bukte@sony.com>, Tim Bird <tim.bird@sony.com>, 
 linux-embedded@vger.kernel.org, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=wFc01ky0wiC8TSKnf9eWcxVo+r/O03nRq6huFbYF7mw=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhqwEy2lBBgX3E3+JMjjHsTiK3O09cf9Fl88XMVEVxhR3j
 wknuXZ3lLIwiHExyIopspQqVf/auyJoSc+Z14owc1iZQIYwcHEKwERytjD8Zkt4VjEl9XLAi0kp
 Qj3HK4/56nq8rM62XOjRcXbSROYtPAz/wwLvqByd6KqwvXh1Ku+tP0+1zs5/ecokJl9rpwJLV2Y
 PGwA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

This is in continuation to [1].

struct device_driver's mod_name is not set by a number of bus' driver registration
functions. Without that, built-in drivers don't have the module symlink in sysfs.
We want this to go from unbound driver name -> module name -> kernel config name.
This is useful on embedded platforms to minimize kernel config, reduce kernel size,
and reduce boot time.

This patchset adds mod_name to usb-related drivers.

[1] https://lore.kernel.org/all/20260518-acpi_mod_name-v5-0-705ccc430885@sony.com/

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
Shashank Balaji (4):
      usb: core: pass THIS_MODULE implicitly through a macro
      usb: core: set mod_name in driver registration
      usb: typec: set mod_name in driver registration
      usb: ulpi: set mod_name in driver registration

 include/linux/ulpi/driver.h             |  4 ++--
 include/linux/usb.h                     |  6 ++++--
 include/linux/usb/typec_altmode.h       |  4 ++--
 drivers/net/usb/r8152.c                 |  2 +-
 drivers/usb/common/ulpi.c               |  4 +++-
 drivers/usb/core/driver.c               | 10 ++++++----
 drivers/usb/core/usb.c                  |  2 +-
 drivers/usb/misc/apple-mfi-fastcharge.c |  2 +-
 drivers/usb/misc/onboard_usb_dev.c      |  2 +-
 drivers/usb/typec/bus.c                 |  4 +++-
 drivers/usb/usbip/stub_main.c           |  2 +-
 11 files changed, 25 insertions(+), 17 deletions(-)
---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260722-mod_name_usb-e3baf58e1e1e

Best regards,
--  
Shashank Balaji <shashank.mahadasyam@sony.com>


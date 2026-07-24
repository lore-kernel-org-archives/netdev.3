Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AF3CF212
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928106; cv=none; b=PaQlYzZfuYA2MQT+tHjB9GeaTcbZkyPu2YE7I1xzoIOoj6o2rXvOlhjOPOa0fpu2JUNt3KOC8IXQHQoGZKjA4MWIHN+J4lcnDDDi9/u69b5OL7bVAGUWKqit+3zdw61F4y1w3/pXaOc2QWJIqMsQVLtgCBdVh4DXcoUCluNBKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928106; c=relaxed/simple;
	bh=/zOqAC4+Ompelo1IUkmo5yf1nOh1ERPexeypHOA/Xdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=stekLKoI0ojDpMjS3JKdNvBvmLvx4CM6QgFRo+P/FpDwEqVeQ9bUhADBiBmd+HO++H4giH9ywjug2aq/XOGX8J9aTObsdwWcwUTwSVBCdVi7jzeqjeg5LwsfWcMp+/nkq6dIpHOBplZtEY5yViQUAVVP4Dt6cTjHwdTtrfSBj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iji/ohKT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iji/ohKT"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84847482584so696405b3a.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928103; x=1785532903; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FQ2nZV4mae9urUpcNtLvt+1onS2Wo4KozDXQHkgV0sw=;
        b=iji/ohKT0XeNR9LLi8SoEHdUJhLewki3GTVE/crz1pfwcOqK/eEkhRS9p7kepnnPMX
         dpncnF46Ir1otSG5LqIzET0R3CBrNqTUQmpyovFE/iT4324Tg1nHRWvYo5zFjqQ6++W4
         QBO+I0sUrNbC2Wbonz37c3GFpHq2SZEN9ffuu2lPCqCVcdDhfnYr1Nwf7MZz0caOyta5
         m928ffmqxi0+jCGWAO6o4HT4ceFsHrl37YHtl3phHe9hgYZDpx2BB9HmthOiTo9gwMZb
         cBX9OBytjGZWg1O3HZMaL+S9U2t+X3D8QNtw+3DG/8hj3XCizvK7GqKU+wz4Yr2f7dAZ
         yQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928103; x=1785532903;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FQ2nZV4mae9urUpcNtLvt+1onS2Wo4KozDXQHkgV0sw=;
        b=ffe97xJa+hXj+24MNrPapUw/O38sQnYos9vG3tqVtkPgaUY8Ymr5d8qEYHCR4yoSvr
         dAS8wcMQtjyf9wYK2R5wNFYrOnW1P3/4Rw+onZVV0ZObd/Xi+YaSKGUYtIxVsRma7pvN
         shRFnJUTXa8hNG2SratpL9noQeNT2L9zTAuBFc8oj5murotSyNnsY0i0r+gcpiK3QOnk
         pZQyWxMdzivJXUj79ic/ndLP5WykbF2w/COplNruLpci4IORUXmumgDS/DqZok3j3miG
         jV4XdpI7gCFBZVgnEDX0/VMJiEutPRRjnLSlcnui/ruaKpzYAGo9gZc2TMCduxz8LVNY
         wFaQ==
X-Gm-Message-State: AOJu0Yyn79b09o2f8K8NFXc6kE4SPMeCKyiEfDGDGwCz/WSDLq9hpnmD
	4g/r6qTaF/CwpjvbZX7Qc1kDjYxNBGqA2+HB46U6qEoqFIMbI4HOh0IN
X-Gm-Gg: AR+sD12SEX4MpgLcgR3cAR1gTQ9wv7OQ9rSJZA46UrYSu/XGaG8zoqzNxSgoP6cGXA+
	MB7qkCnUgqNsLz21T1JCNceEnO9HQ8/ncsw+V7SpTPpHzdRHk8ZgsJ+TVCn7YjD5IZXj4PHXFvv
	5GzwqKL7E2JImcg8aH8c54pgSShC51/gqp7eDqkUA6pqaQ6fOsUPSoESIghVDBly8iFsq2eWfo3
	hkrdrUq2oaC2Ky0IDSp+r4yLJTIubItGRf19R8B7wQ26saEsKeu+PNc1RU5i1r8H0KGN/BafKNc
	fXtDMFs4Em8vmZNyTxgxxl/IkgjYjvpHav+mkS0OW+k2/T8FOjiqcWPauK0c0wQiNz6b+Rz1zR8
	iYKDqNHopLpBqvpbZyqPRCz8GYsqR8L8jdTtv4oGQkM0RIQYuz02L74R2LCiRfe3Vkm0ez4W7WJ
	Gbvw+Jh7o5BAiqEAsmjpFnCvoG1gPaSDs6Nyi+F9XwkscuMy3XaDFiK1Q=
X-Received: by 2002:a05:6a00:4213:b0:84c:241e:9070 with SMTP id d2e1a72fcca58-84e4e915478mr1649451b3a.17.1784928103363;
        Fri, 24 Jul 2026 14:21:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f7cesm453963b3a.18.2026.07.24.14.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:21:41 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v6 0/3] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Fri, 24 Jul 2026 14:21:14 -0700
Message-Id: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAErXY2oC/23PzWrDMBAE4FcRe/aWlVY/jU99j9KDrKwSQW0H2
 4iU4HcvmEKN8Xngm5kXzDIVmaFVL5iklrmMA7TKNwrSPQ43wXKFVoEh48mTwSU9rj1+x+kmOJS
 xzui8Mxw5agoBGgWPSXJ5buYnDLLgIM8FvhoF9zIv4/SzlVW95X8un7hVI2HmEG1MPhifPnpZ4
 lsa+w2rZgdofQYYJBQxXdZOgjN8AHgPnD2rjISRO39hCT6n7gDYfyDQ6QKLhCla72zm4AIdALc
 H3s8Ah4Rsu+xzTBer9wvWdf0F0DtiCr8BAAA=
X-Change-ID: 20260602-tcpdm-large-niovs-56523a3a1077
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com, 
 dw@davidwei.uk, Joe Damato <joe@dama.to>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

Every devmem dmabuf binding hands the page_pool PAGE_SIZE niovs today.
On NICs that consume one descriptor per netmem, this caps a single RX
descriptor at PAGE_SIZE and burns CPU on buffer churn.

In this series, we add a bind-time netlink attribute,
NETDEV_A_DMABUF_RX_BUF_SIZE, that lets userspace request a larger niov
size (power of two >= PAGE_SIZE). Drivers must opt in via
queue_mgmt_ops.QCFG_RX_PAGE_SIZE.

Measurements:

Setup: kperf devmem RX/TX cuda, 4 flows, 64 MB messages, 60s, dctcp,
num-rx-queues=4, dmabuf-rx/tx-size-mb=2048, 10 runs per niov size,
mlx5.

   niov       RX dev Gbps   RX flow avg Gbps         app sys %
  -----  ----------------  -----------------  ----------------
     4K  300.63 +/- 53.21    75.16 +/- 13.30   54.15 +/- 10.23
    16K  321.35 +/- 28.20    80.34 +/-  7.05   41.05 +/-  8.87
    32K  347.63 +/-  2.20    86.91 +/-  0.55   44.54 +/-  3.51
    64K  332.11 +/- 14.26    83.03 +/-  3.56   35.47 +/-  3.11

RX app sys % drops ~19% from 4K to 64K.

kperf support (not yet merged):
https://github.com/facebookexperimental/kperf/commit/8837577f920876bce6986ec18869ac04439ebcd2

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v6:
- Rename rx-buf-size to rx-page-size (Jakub)
- Move the >= PAGE_SIZE check into the netlink policy; doit only checks
  is_power_of_2() (Jakub)
- Drop @ksft_disruptive from check_rx_large_niov() (Jakub)
- Link to v5: https://lore.kernel.org/r/20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com

Changes in v5:
- removed unnecessary change from ssize_t to size_t (Mina)
- removed '--------' lines in the commit message (Paolo)
- removed commit msg about CONFIG_HUGETLB since that change was already
  merged
- Link to v4: https://lore.kernel.org/r/20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com

Changes in v4:
- ncdevmem: fix the possible overflow in ncdevmem (Sashiko)
- drop the udmabuf patch because the fix is now already in net-next
- silenced two pylint complaints in devmem_lib.py
- Link to v3: https://lore.kernel.org/r/20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com

Changes in v3:
- fix a bunch of non-reverse christmas tree declarations (Stan)
- remove extra uint32 cast for getpagesize() (Stan)
- remove overzealous strtoul checking (Stan)
- remove value checks that the kernel already performs on rx_buf_size
  (Stan)
- Link to v2: https://lore.kernel.org/r/20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com

Changes in v2:
- Use NL_SET_ERR_MSG_FMT for sg alignment failure details (Stan)
- Keep -E2BIG (not a direct ask, but seemed preferred, Stan)
- Update udmabuf commit message and comments explaining why
  "one sg ent per folio" is useful (Christian)
- Set/restore nr_hugepages in py harness (Stan)
- Link to v1: https://lore.kernel.org/r/20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com

---
Bobby Eshleman (3):
      net: devmem: allow rx-page-size > PAGE_SIZE per dmabuf binding
      selftests/net: ncdevmem: add -b option to set rx-page-size on bind
      selftests/net: devmem.py: add check_rx_large_niov

 Documentation/netlink/specs/netdev.yaml            | 17 +++++++
 include/uapi/linux/netdev.h                        |  1 +
 net/core/devmem.c                                  | 49 ++++++++++--------
 net/core/devmem.h                                  | 13 +++--
 net/core/netdev-genl-gen.c                         | 11 +++-
 net/core/netdev-genl-gen.h                         |  1 +
 net/core/netdev-genl.c                             | 18 ++++++-
 tools/include/uapi/linux/netdev.h                  |  1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   | 11 +++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 59 +++++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 36 +++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 10 +++-
 12 files changed, 190 insertions(+), 37 deletions(-)
---
base-commit: 89d8006259b81dd25c962f6cc8d7ab268d6ea426
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


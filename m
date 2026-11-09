Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213469;
	b=FVG/1FQznU43a8Q3uq3JAx6zq+6g3VoPn/HGD5b8BLzHb1caDwpeIj5zTINClvmLMVBD
	 qBP46CgGGIipExgJ/avj6XnPUbb3StoPOtAqfKyBt1FDt4H0hJuvN2e/vDzjNxVaPZ4ss
	 4rZPBleNhDJ1+aez+HHxrGswnJzYLTox7OrqvdnPNGoE5aYoMO604jHb+LYeZYaSuPImc
	 35fRyr3I1rUUwMbL6090KFwNnNUbG7QtF9Mt0Am2iMmSnRhojmH7S2ztTYPuM3oa2YGEi
	 sKEwbx7MTR0Sjztmru3/fM7aUyDqrrktSdrxy8VuQDLKlFazusnBe+uUCkvbNjna/wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213469;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0Fyj5xlPc8azC7Nb28RFnfz3cVM+uNyzYf8DL1GWdVM=;
	b=S5trMedZ1bpLgpsICjpH+KIIdPdNQATUg1jG8qEn02FEX+PoZevMJGW18U/iNLKbdY/O
	 zYSuYhAsmPkSjnCzsU39l6qL5vnKzNtee3J0PzvJSt9ADOhAs0KHnlKHePhtvGauCA534
	 79Za29iN12j2cA04rsx0uAqxIgjepz3K4bieCw8VKoaHGSGqiLeN9FCrQ8tTzF27OzYbT
	 GDKtJb1AWPLX6jhPRp7iAPmBOz3I1mKG3n7ViDgcpvMuHfhhAFu33Om8Dv7aWRqj/BxUy
	 EQZelIBsUZfbdkTqWOBUdT8sjX1Mb0sWyI0SWXT/+HG4WhR5qovestjDGr92yVx3reQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=JkW6qP7a;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0E0606D81B;
	Mon,  9 Nov 2026 08:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B0E0606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=JkW6qP7a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=JkW6qP7aelm29RnvG6QDOgxPr7bdP6+bD76LzKrzPjFy8mzZ9HJQVHDdkHMTxUC9+5cRkE6jbqe3/
	 8elLFgsxIDGjqZF6O8HZxaXM43O1ukFKA8uYW54O7uW7DqTvd8iVKdvcU9iene5Rg2LTng1HMeLVeN
	 5xaW0WmygQJ0gy5U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af18635473-6323e;
	Mon, 09 Nov 2026 16:37:09 +0800 (CST)
X-RM-TRANSID:2ee46af18635473-6323e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af18632c1d-886d9;
	Mon, 09 Nov 2026 16:37:09 +0800 (CST)
X-RM-TRANSID:2ee86af18632c1d-886d9
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Haokexin <haokexin@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix device_node refcount leak in prueth_probe()
Date: Mon,  9 Nov 2026 16:37:06 +0800
Message-ID: <20261109093000.54321-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <179335079339.3327.14537748743173383861@kernel.org>
References: <179335079339.3327.14537748743173383861@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please find below the additional information netdev-bot requested
for this series.

How the issue was discovered: manual code inspection of the error
paths in prueth_probe() while auditing the driver for probe-time
resource leaks.

Whether the issue was actually triggered: no, it is purely
theoretical. The affected branches only run when the "ti,mii-g-rt"
or "ti,mii-rt" syscon regmap lookup fails, which happens only with a
malformed or incomplete device tree. On a valid DT these branches
are never taken. When they are, probe() fails with -ENODEV and the
of_node_get() references taken on eth0_node/eth1_node earlier in
the function are leaked silently; there is no stack trace or error
message pointing at the leak itself.

Hardware the change was tested on: none, it was not tested on real
hardware. The change only re-routes two error branches to the
existing put_cores label, which is already exercised by the other
failure paths in the same function (e.g. prueth_get_cores()
failures), so no new cleanup code is introduced.

Regarding the Sashiko findings:

- The leak in the SR1.0 sibling driver (icssg_prueth_sr1.c) is real,
  and it is fixed by a companion patch submitted at the same time as
  this one:

  https://lore.kernel.org/netdev/20261030085851.2019-1-laixiangwu@cmss.chinamobile.com/

- The port-node loop issue is acknowledged as pre-existing and
  separate from what this patch fixes. References taken inside the
  port scan loop can also be lost on unusual DT input (a duplicate
  port reg value overwrites eth0_node/eth1_node and leaks the
  previous reference, and port nodes with a reg value other than 0
  or 1 keep a reference that is never stored or released). Fixing
  that requires a wider rework of the port parsing logic, so it is
  deliberately left out of this patch to keep the fix minimal. I
  can send a follow-up patch for it if reviewers consider it worth
  fixing.

Best regards,
Xiangwu Lai



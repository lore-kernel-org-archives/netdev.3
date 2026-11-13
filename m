Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794550015;
	b=YoZEE7Wv0gswnvpCLfYV82Q7kbVpmECVt72lwPxOHU42n0zcvJcxg2x7BCGE96n4OFG2
	 aqElcDZQ0UsMyuXR9E1MCJhcN4Bv03zK63IJIvI5d1yt/amV9TNRp/C/yaIDMiW8uWvX+
	 9wWqnavJs4C73yBGn64zbDsEH4OuN60klIK40CvFO5WZ7zyy5Tn4xTMDPJ97a/ceg4DDq
	 EG6dXPdfqKW22HQZgf2G5YdRbtUECvE4eNKyj5XQ8E99MM8UuSCPQK20MxYDCqGD1aQbQ
	 GsBABt56HfT4k89scem37Mt4JqRjBoc5FWewRBW+XRPItJcgs2sc9ddk1oc7IP1Ufgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550015;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=viXfMTSocRFfhtxQ088X+ltdjpYfBvb+DJQ6aCTNoZA=;
	b=5Uz3dZ7mMxNoFTtTJWRkUA0N2zufsfOup0i6Bst8EopA4msd9ardQmvdZhuSwLIkEbYK
	 E9sLysp3+Yg9htDl6Y4OtCqmXkVtoZPr5ie/BZhp3Fps+v8IfRsfegrxMC4YIFUuFBwQL
	 sil9XSq0jSJBZ5Wuzjy0n7WW9MphoPCUirUEGmvS7AjfELuOFGG0bmparJkfbJyABP/hp
	 jqTUqe7Fu0j8xBTjAjmkKYAZtOGrVt7NzcjtC/zKwkVqgy9rXbrQ4H9iAA4iNk/Oh3MNE
	 pzspXzAS0H2td2JEKoFlZmjlRg5opHpb3a5U/vyKzgCq28LAQDl62basGeAoo2sQlVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=UWuxxgRq;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802DB606A321;
	Fri, 13 Nov 2026 06:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 802DB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=UWuxxgRq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=UWuxxgRqxwJ36XtLy9fUk/WmhJpu61LDHoI7SkybtzWEjhjg0QnFmw7NNMfGkKMp132S51QuwhSnf
	 CQBIAivimOvuaGMNgmOfh5CIHkWIKwI0UWev8i0Nsl+QBwH/MuwIduVMVagr6j3Af6miOI0Kxf81vx
	 YRopwsMp3AmqBrfY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af6a8f1b92-c414d;
	Fri, 13 Nov 2026 14:06:43 +0800 (CST)
X-RM-TRANSID:2ee16af6a8f1b92-c414d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af6a8f1fac-199c0;
	Fri, 13 Nov 2026 14:06:43 +0800 (CST)
X-RM-TRANSID:2eea6af6a8f1fac-199c0
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	MD Danish Anwar <danishanwar@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: Re: [PATCH net v2] net: hsr: clean up synced addresses and allmulti in hsr_del_port()
Date: Fri, 13 Nov 2026 14:06:23 +0800
Message-Id: <20261113060623.79812-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <avWLZTnYPQJ2-z7_@fedora>
References: <20261111060143.183670-1-sunwenbo@cmss.chinamobile.com> <avULIJLRzOEoefJI@fedora> <avUQ5dAMMRlUTNzq@fedora> <avWJrwDyT8HJHWSN@fedora> <20261112064716.85381-1-sunwenbo@cmss.chinamobile.com> <avWLZTnYPQJ2-z7_@fedora>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Hangbin,

I sincerely apologize for sending out v2 too quickly yesterday before
giving you enough time to review the previous discussion. I really appreciate
your patience and thoughtful guidance.

Regarding your question on whether dev_uc_unsync()/dev_mc_unsync() could be
called from hsr_dev_close(), and whether they should be removed:

I traced the function calls and verified the behavior in a User-Mode Linux
(UML) environment across different lifecycle events:

1. Can they be called from hsr_dev_close()?
   Yes. When an administrator administratively brings down the HSR interface
   without deleting it (e.g. running "ip link set hsr0 down"):
   - hsr_dellink() is NOT called, and ports remain in hsr->ports.
   - dev_close() triggers ndo_stop (hsr_dev_close()), where hsr_for_each_port_rtnl()
     successfully iterates over SLAVE_A and SLAVE_B.
   - Both dev_uc_unsync() and dev_mc_unsync() ARE actively called here to unsync
     addresses, ensuring physical slaves stop filtering for HSR multicast while
     hsr0 is DOWN (and re-synced by hsr_set_rx_mode() once brought back UP).
   Therefore, they are NOT dead code in hsr_dev_close() and should NOT be removed.

2. Why do we still need the cleanup in hsr_del_port()?
   Because in port removal/deletion paths, hsr_dev_close() cannot perform this cleanup:
   - Master deletion ("ip link del hsr0"): In hsr_dellink(), hsr_del_ports()
     detaches all ports from hsr->ports BEFORE calling unregister_netdevice_queue().
     When unregister_netdevice_many_notify() subsequently invokes hsr_dev_close(),
     hsr->ports is already empty, so the unsync loop runs 0 times.
   - Slave unregistration ("ip link del veth0" while hsr0 is UP): hsr_netdev_notify()
     calls hsr_del_port() directly without calling hsr_dev_close().
   - In addition, hsr_change_rx_flags() propagates IFF_ALLMULTI via
     dev_set_allmulti(slave, 1), but neither hsr_dev_close() nor the original
     hsr_del_port() ever restored it.

   Adding dev_uc_unsync(), dev_mc_unsync(), and dev_set_allmulti(port->dev, -1)
   in hsr_del_port() ensures that whenever a slave port is detached, its synced
   state and allmulti count are cleanly restored (mirroring the cleanup in
   macvlan_uninit() and team_port_del()).

Per your comment on v1, I have dropped your Reviewed-by tag and will incorporate
the detailed reproducer and lifecycle trace steps into the commit message notes
(under the --- section).

Because v2 was sent yesterday at 14:47:16 (+0800), I will wait until the 24-hour
cooldown period has elapsed (after 14:47:16 today) before submitting [PATCH net v3],
giving us full time to discuss.

Please let me know if this clarifies the call flow and whether you are comfortable
with this plan.

Thanks again for your time!

Best regards,
Wenbo Sun



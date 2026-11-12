Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465923;
	b=qtvpXHkHaael+QYt4uctZM1KLR6ziRg8o6gcAgd/bfRRoSKKRpguuzj6XOIrXtNmWWF1
	 XsWbz7Wms5WcMG534FmOP6CnDGFb5vDAvvZy3KWX/M+9s4UM4uEbSIzpn/OdgtMcwwNCn
	 muU+ncYa6tVKEZUqLHRia/4T+QNWygQEmAI01VPX4BZAyjge/l1WVQ6ut1yY0Rm/G+BDc
	 9hYlgc5Cz575+TtF99QJr8ubmN0SLNAMrJe/KJOF9KgpPruIcQGWl/4lIy+SaCO3ICXGH
	 ovG4xvsI3rA7P6bIfISYpLnwbSMo3lsJ9DbQfnQUe2xfJL2hbmvLqe8CLdVDW1vjB9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465923;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PH7FPXKmXWwh86LBiWXSpBFcw8LkkIhddh/M7mADpoA=;
	b=ZKBNAIheHnlGqLg20KbOs6f/GSNPcNXlHzokI7+ZNPXmmCrTXn+Co/7kKhCO34XPOc+7
	 uVqITwHOEJZVn1hhY+6p//zEIcTjpDuOemK7LooeH0WIuGMwQplZt1gqo3fZwE64p1u+8
	 8/DUIiQz4eAuJGwYpgZMDm8U8N907JAUawHWjPgULffJ+dHolqtmMdflTCey7hbtVJH+f
	 2X+BRZ+EHmAy5YiLRccS0GUXARpYrW4j/56ow4Gnd9+rwHP9SejMwJbt6phGGaPPu1Hdy
	 h3KVy/nG0Qd1n63Fhe46wCKmzVj50Gaqq5ezZy017qwM3c8ybVV5j37SxN5tQe8Irlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ymSbpqUV;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C9606A31C;
	Thu, 12 Nov 2026 06:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B10C9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ymSbpqUV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ymSbpqUVBIpRATdz2wahkZ5KpQq4S30Dx1UdKRR9ULig5alk8DxYjdz+IYafo7AXDZNX+5MfTne8F
	 YVMxXQc6SVk4vFkh16+bhcGX5QJKaIOjCFVn1qt0GfDyQIOCiYXkUiYIToFnKQjhqjY8eLxp+xaHCm
	 /GekKm6UupsYvRTE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af5607e80a-7ea8d;
	Thu, 12 Nov 2026 14:45:19 +0800 (CST)
X-RM-TRANSID:2ee86af5607e80a-7ea8d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af5607d33a-f5871;
	Thu, 12 Nov 2026 14:45:18 +0800 (CST)
X-RM-TRANSID:2eea6af5607d33a-f5871
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	MD Danish Anwar <danishanwar@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: Re: [PATCH net] net: hsr: clean up synced addresses and allmulti in hsr_del_port()
Date: Thu, 12 Nov 2026 14:44:59 +0800
Message-Id: <20261112064459.81535-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <avUQ5dAMMRlUTNzq@fedora>
References: <20261111060143.183670-1-sunwenbo@cmss.chinamobile.com> <avULIJLRzOEoefJI@fedora> <avUQ5dAMMRlUTNzq@fedora>
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

Thank you very much for the Reviewed-by and for raising this question!

On Thu, Nov 12, 2026 at 09:05:41AM +0800, Hangbin Liu wrote:
> Sorry. I just got a question.
>
> hsr_del_port() is called via dev unregister or hsr_dellink() -> hsr_del_ports().
> The hsr_dellink() also calls unregister devices.
>
> The unregister process will stop a device if it's up. And hsr_dev_close() has
> called dev_uc_unsync() and dev_mc_unsync().
>
> Could you share more details on how you performed the testing?

Here is why hsr_dev_close() does not clean them up in those paths, and
how the test reproduces it:

1. Call order in hsr_dellink() (net/hsr/hsr_netlink.c):
   hsr_dellink() calls hsr_del_ports(hsr) *before*
   unregister_netdevice_queue(dev, head). Inside hsr_del_ports(), every
   port is removed from hsr->ports via list_del_rcu(&port->port_list)
   and freed. When unregister_netdevice_many_notify() later invokes
   netif_close_many() -> hsr_dev_close(), hsr_for_each_port_rtnl(hsr,
   port) sees an already-empty list, so dev_uc_unsync() and
   dev_mc_unsync() are never called on the slaves.
2. Similarly, when a slave is unregistered directly while hsr0 is UP,
   hsr_netdev_notify() (NETDEV_UNREGISTER) calls hsr_del_port(port)
   before any close/dellink takes place.
3. Also, hsr_dev_close() never calls dev_set_allmulti(port->dev, -1)
   (and dev_close() preserves IFF_ALLMULTI), so the allmulti refcount
   leaks even if hsr0 is brought down before deletion.

Here are the exact test steps I ran in UML (using veth pairs):

  ip link add veth0 type veth peer name veth0p
  ip link add veth1 type veth peer name veth1p
  ip link set veth0 up && ip link set veth0p up
  ip link set veth1 up && ip link set veth1p up
  # Create hsr0 with slave1=veth0, slave2=veth1 (RTM_NEWLINK)
  ip link set hsr0 up
  # Set IFF_ALLMULTI (SIOCSIFFLAGS) and add 01:00:5e:00:12:34 (SIOCADDMULTI)
  # Verify IFLA_ALLMULTI on veth0 == 1 and /proc/net/dev_mcast has 01005e001234
  ip link del hsr0
  # Re-check IFLA_ALLMULTI on veth0 and /proc/net/dev_mcast

Observed results on unpatched kernel:
  [BEFORE DEL] veth0 allmulti_refcnt=1, synced_mcast(01005e001234)=1
  veth0: left promiscuous mode
  veth1: left promiscuous mode
  [AFTER DEL]  veth0 allmulti_refcnt=1, synced_mcast(01005e001234)=1

Observed results with this patch:
  [BEFORE DEL] veth0 allmulti_refcnt=1, synced_mcast(01005e001234)=1
  veth0: left promiscuous mode
  veth0: left allmulticast mode
  veth1: left promiscuous mode
  veth1: left allmulticast mode
  [AFTER DEL]  veth0 allmulti_refcnt=0, synced_mcast(01005e001234)=0

I will also send a v2 with an updated commit message noting explicitly
that hsr_dev_close() sees an empty port list (along with your
Reviewed-by). Please let me know if you have any further questions.

Thanks again,
Wenbo



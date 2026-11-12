Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455534;
	b=5WQAuAUVN43+KK8TjwdDhydqWAAt9RnZBaUXSdSI+eR5Ffo75oTOlGEaqOBdKmjpygu0
	 qtlTk0kX/+wofyeY/+/gOME47HHymjuXhdLYfmJ0j411O6tTpztz7fqqWNcWwxihKUBhD
	 z9V1SVjKQEJpFuEifQ+K91eD0paEw6J/JdkdRcr05H2PkSFA5XI0Lt4WYaWMvcR+b1UAe
	 siUQ0m82DwjufJtUzEkop+J/F1PcmEaGrnwzvW0zR1FNOLG9YmTynHWzc/8zFCvYg7s+e
	 SL4WGelZtcycQH3HweeqlAzCL25uP+5/CNK36q8y1EJuc9Q0Negl7Gh+MytIr9BajRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455534;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oJjEKVEAKHGwMXnMBrqjNVfsEmgIQU1/u5wEHFXaSQI=;
	b=gtQxA4LLbBQXJXOJEeJF/ah5I7UiGUBCF7d/Zwj5nb2/pt62o0Q24kmE2iiVlQpinofQ
	 MSOIpxInrIhkcv2wdcjQrdVcNt1D4BRSawArcqHyEtb3UghoSJtG6j+lAKjsZUhpsiKA+
	 EuEPNbB/J2c+7m8SroSwJ+foLD22WrkWD+FjEn1elhDRToOu84+hvAmVoJbneJD/ga6V/
	 JfKXKa/l4/7gC77/ps5xxRLmyvlEJJvar1HL9NNKKyZO1hLBfeAp8B+NIHAEjyUPgqQFO
	 x6v68R8AGbaszg+nY2VLx+I2Ol8KVZ+IQgkAxJroixtWwbcSwiL6sYkTJUvP+8Pfd3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="bQLh/WyJ";
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7C606A321;
	Thu, 12 Nov 2026 03:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA7C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bQLh/WyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bQLh/WyJjXEzqZ1pf3Ouk4IxgieDVprTMltgLLD+ANL7q/yUSPnDYjxiOXeqslwae6/DKW3+HvWc2
	 bekKDE6qPC3ufHNHJ5WlqCOsWSE/86Qb1fgdMHcfInBUc4qp0VY0/nelUOHaw5cXFDZbDHpnJXN0Fb
	 nR5Rs7kBgHOGsmtU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af537eb6b7-aa3f9;
	Thu, 12 Nov 2026 11:52:12 +0800 (CST)
X-RM-TRANSID:2ee66af537eb6b7-aa3f9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af537ea705-f1ab7;
	Thu, 12 Nov 2026 11:52:12 +0800 (CST)
X-RM-TRANSID:2ee16af537ea705-f1ab7
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Mahesh Bandewar <maheshb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: Re: [PATCH net] ipvlan: update port flags only after ipvlan_set_port_mode() succeeds
Date: Thu, 12 Nov 2026 11:51:52 +0800
Message-Id: <20261112035152.43363-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <avRnWUbGFbdfirZB@fedora>
References: <20261111064655.233265-1-sunwenbo@cmss.chinamobile.com> <avRnWUbGFbdfirZB@fedora>
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

On Wed, Nov 11, 2026 at 09:02:17PM +0800, Hangbin Liu wrote:
> If ipvlan_set_port_mode() failed, the unregister_netdevice(dev) will be
> called. Does port->flags still need to restore?

Thank you very much for taking the time to review this patch and for
pointing out the question about the commit description.

You are completely right that when creating the first ipvlan device on a
lower device, unregister_netdevice(dev) drops the last reference to the
port in ipvlan_uninit() -> ipvlan_port_put(), destroying the port so no
flag restoration is needed.

The issue happens when one or more ipvlan interfaces already exist on the
same lower device:

1. Because struct ipvl_port is shared across all ipvlan interfaces on a
   lower device, ipvlan_init() takes an additional reference via
   refcount_inc(&port->count) when creating a new ipvlan interface.
2. If ipvlan_link_new() writes port->flags before calling
   ipvlan_set_port_mode(), and ipvlan_set_port_mode() fails (for
   instance, requesting L3S mode when CONFIG_IPVLAN_L3S is disabled),
   unregister_netdevice(dev) only decrements port->count back down to at
   least 1. Since ipvlan_port_destroy() is not called, the shared port
   remains active for the existing ipvlan interfaces while still carrying
   the newly written port->flags.

Rather than saving and restoring port->flags on the error path, moving
the port->flags assignment after ipvlan_set_port_mode() succeeds avoids
modifying it on failure altogether, as there are no remaining failure
paths afterward in ipvlan_link_new() (matching ipvlan_nl_changelink()).

I see that the v1 commit message phrased this awkwardly ("never restored")
and did not clearly distinguish the shared-port case with existing
interfaces. If you agree with this explanation and approach, I will be
happy to send a v2 with a clearer and more precise commit message once the
24-hour resend window passes.

Thanks again for the review!

Best regards,
Wenbo



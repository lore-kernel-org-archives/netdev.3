Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553725;
	b=dR0P0FmvsO5ZluuplrOEGjKXbetf1nVT/egGop1nMW8QGh88wfM63zI/46WTdo7f/S1j
	 ttuT8mbdTnrYMNQUK62u7k6xfYQqpj5VTJIcb/BtM6kc1ktz0lBxcG2dc3yMMJtuP+nxs
	 Acz15r5Fvt1/T23yZjslrlCxA4yg4+PAvxy/i9WSU2rZYQDatqzsEifixkROux1Ka1/fi
	 vZcXPq5NOkHeugSPmSsnedT/oOfO8tPCWbHIT6WS91h36UAnP58LjU7pR5gszeV6KbhiU
	 rqAl/Obtd6iUZObhagQfZRsUrJ6i88O3s4um6VpsBVv20dXo0UW6TOeT2SIvE6v+lLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553725;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=m5gdk+W3xc3fFZcALv8c+D0FiAHcjAVtduRb63rDx+E=;
	b=wnp5nAL/eA4dTicF67vfcjgs6URLrW6fns8/QWJ2fi5XoWZicKSBPSmaVR98ulwowrGD
	 ungMm4vyyqGJCXDkY2YPW9yfRG7Vaweyg4L4aq/mJziXiLkb104jl+U8WZeEVRAJtGhqn
	 BtXmbJ5AszkFPJt5t5NDSELu8S20gr6Itc95WRxNHUQ+5zyM7sLUMyrdthzpr3kR6gH3C
	 vC6ruuGIVZpsluQ9ag25UaZa8Khz6SyEsTdsNvnyUQ5lIJcTOB/N/psZgul8FNpyMAJua
	 +gMYsTfrA5w5crH7k5JiUmDhZWPf7f9EM9mc7f80t5T4rK84b3o+xugT87QUDM5Z80g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=wZo9or7+;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF51606A332;
	Fri, 13 Nov 2026 07:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF51606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=wZo9or7+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=wZo9or7+nayuao3oIBZYldvfUXy/6D1ZTyPx85wWgmubcejTItbvAS1PmScF11gEdyY1hWYTGr0Tj
	 NvzmPR2ZAb12mGxqPWIgy9MWvCe/XHFWIX/P/DvE2VTD0H/N3Pej1qVl2NBF2e1gU/co2LA1TCxTE9
	 CCnjY+/dvrKn2ueY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af6b76b755-b512f;
	Fri, 13 Nov 2026 15:08:27 +0800 (CST)
X-RM-TRANSID:2ee36af6b76b755-b512f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.35] (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af6b76a94e-1c0e5;
	Fri, 13 Nov 2026 15:08:27 +0800 (CST)
X-RM-TRANSID:2ee66af6b76a94e-1c0e5
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
    dsahern@kernel.org,
    idosch@nvidia.com,
    davem@davemloft.net,
    edumazet@kernel.org,
    pabeni@redhat.com,
    horms@kernel.org,
    linux-kernel@vger.kernel.org,
    kuniyu@google.com,
    xeb@mail.ru,
    yana06070@163.com,
    netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH net-next v2] ip6_gre: fix changelink conflict checks for L2
 tunnels
In-Reply-To: <20261110205838.2246603-1-kuba@kernel.org>
References: <20261104150330.70963-1-yanxia@cmss.chinamobile.com>
 <20261110205838.2246603-1-kuba@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri, 13 Nov 2026 15:08:18 +0800
Message-ID: <179455369855.86815.2266186229377426627.ip6gre-v3-followup@cmss.chinamobile.com>

Hi Jakub,

Thanks for the review. I've dropped the collect_md filter from
ip6gre_tunnel_find(). v3 only changes ip6gre_changelink_common().

For ordinary devices, it uses dev->type and rejects a match on another
device, including a metadata device. For metadata devices, it updates
the device itself without the ordinary duplicate search, as newlink
does. The newlink, legacy ioctl and receive lookups are unchanged.

I also moved the conflict and unregistering checks before encapsulation
changes, so these rejected requests leave the encapsulation unchanged.

I tested both L2 kinds under UML with ip6gre0 present, checked the receive
interfaces and tunnel metadata, and ran the legacy ioctl checks.

v3:
https://lore.kernel.org/netdev/179455350258.84965.17518172977020586093.ip6gre-v3@cmss.chinamobile.com/

Thanks,
Xia Yan



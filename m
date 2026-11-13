Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560275;
	b=MD8RO73BvS+ltA5B4mdYJnlD4WbBzvdMNK+83tKZ5TbUQ7IaIAPHrm/9lEcqZC/kdv+G
	 sq1AAM8poO/P78LSyOa6pJYyg48ibIT4sM4hYVgi+ugYjDlgsrhKSCF4Dts9Ru42hp4Vz
	 yP4H/KJsYCEuD98owxyhn+3DfGbB6jjJj7aNMhz7T4ieuOoJymCrfmrkRnPQ9If15vOAM
	 h/BUSKe66xDKrMezz8vGu7yiQnOsyCl1eEb0OEVjgNDzbGY9sMwNeVeejimK/xjlGsXH0
	 HTVGkSoSFNuhwigKV7ttAp+r4CRqDV8S6ewxbK5AcXncboap/xRHnivAWVAceErIvDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560275;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BjKgwNk/hfR6oAW/crTzv7g8ELfpDaNgSZwDrwnUj+w=;
	b=4yeO5pZYLT7gV7mohkcdAvEl1gbxDnwpvvDZdvBT6otgWj22ukW7WC1na6xOKVerclf5
	 BNBwSv20NLdnICFVrIkS7+5YUPcJJ/5T5tX+WVgW4P5JarBBdBnURlnGNjiTUCFt2RM21
	 i2JTEJxNeSbL9LAW4+e9eMYhk03doJEI7ajJqnXbrKiPQjxWHfiyPF3jqp6sQ49v5ErEO
	 f1pBfZE+auFUUsoUVwiiEL4cYYncneKrYNI/c2LEhcT2QLUudB97V4DXnoCYZdjplkJJM
	 ZJ/AJkoLZsWyxaCUy0E8fZ9DVIbD8GemXyafEy7dSv614CfdH0wcQJ1X1crYCnoh2+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=I2HJqNSC;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA6E606A31C;
	Fri, 13 Nov 2026 08:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA6E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=I2HJqNSC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=I2HJqNSC36CKoRBkVR+wR6vxrkRQBWd4YkIUeqJUL7uWu/VIGKjSn6hOG6/RfixsGTw1zGZgJn4qD
	 tgmFZo/fdlIOoH9iuqU7eO65IiraoGtHvcrUrG08rL6eAVRmaN1/pt3rkkyPEoRxGe0IdP/3AZs84A
	 fuW+ldjXnKRoEOGk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af6d10cc1e-eb6ea;
	Fri, 13 Nov 2026 16:57:48 +0800 (CST)
X-RM-TRANSID:2ee76af6d10cc1e-eb6ea
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af6d10b888-1f14c;
	Fri, 13 Nov 2026 16:57:48 +0800 (CST)
X-RM-TRANSID:2ee86af6d10b888-1f14c
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: Re: [PATCH net v2] team: validate the length of U32 and S32 option data
Date: Fri, 13 Nov 2026 16:57:28 +0800
Message-Id: <20261113085728.169050-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ava3_g_zsVdAjn93@fedora>
References: <20261112090030.172342-1-sunwenbo@cmss.chinamobile.com> <ava3_g_zsVdAjn93@fedora>
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

Good catch, thank you for checking the commit history!

On Fri, Nov 13, 2026 at 03:10:54PM +0800, Hangbin Liu wrote:
> This part should be
>
> Fixes: 69821638b274 ("team: add signed 32-bit team option type")

Indeed, commit 3d249d4ca7d0 ("net: introduce ethernet teaming device")
introduced TEAM_OPTION_TYPE_U32, while commit 69821638b274 ("team: add
signed 32-bit team option type") later added TEAM_OPTION_TYPE_S32.

I will keep this as a single patch and add:

  Fixes: 69821638b274 ("team: add signed 32-bit team option type")

alongside the existing Fixes tag, then send [PATCH net v3] after the
24-hour resend cooldown.

Thanks again for your review!

Best regards,
Wenbo Sun



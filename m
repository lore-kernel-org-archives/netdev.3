Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196359;
	b=HsPbO2HrFabteF2OBmr7tkBP/ssc/+zxUUT1AoVEpClselm84mYytZ+i+9CDoLn/zrUD
	 88j4dP1jsCKHuz9vFcgkJpvU5glYmE7fZiMbLX32ytO6xZzdYuooJW0I2QDCSg/EjAKhs
	 qm2n31dDG0BL+C8+cGpHeN1hGxya3JWb3IgIcwLG7G/0LF3woaKb4eUC5txVCkS0FvcM8
	 ydnT+7sxo6lh4p4XsWN9Hz5cbuoOeeY9HhD0OwpU421OCi2deKtqaFYHc+biIBjVoVxBR
	 PhVJVVR9plo0QaN6ua1uEXaGCJgdTuwC+rcjyjNs+zftPsnRO2Z3r+K1AeGLgi3zS4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196359;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=UVNf9XVGQ9iwewOtqIQdfWKo+D0otSzQYSZuL2dIs84=;
	b=viZfWSuOzyhVbMnWW1ZRdh7tQNSV84EyrderGC0INAjMFyJl4h+o53EdH4pMxmihgz8w
	 exakALMMu4aPNt1pfy9ScHt7mmQvuQwh8NX+z7r2MqjWjH1veDU2Ra8rKUx9xN0TX8jxG
	 I4RlrBKPER8f2wSXIc3sTirS/3ssrOxIq8xf7RYXmFBUf9A2n4UVT905zxFiUCWj3hBro
	 jmQeUE1EdtdQrXI9vWKqc7VlKIYgcQdyQPGknVPtBv/NIFFMFgGev+gb4lfL1bxQn0UFF
	 IT2fOIFlAS4qAiu3NEje/BldBJD8G/gvh6Twuu0axbR55h090mGZoNkR9Z2l2Xa6MDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Ve4dq0We;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E51E606A31C;
	Mon,  9 Nov 2026 03:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E51E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Ve4dq0We
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Ve4dq0Wef+DYULKFxR31cYHOIux8HOb3yvxrfd8gJMxr4mjTzCPlwEe1MNMhhsQc8854/njOGzPFN
	 GODg0cGMdhyrhx9Ki8KMHP6wBDmTxwNVtPl/vdKAwGdDSwB4tBbijiHwej17g1H8COt03wcxuzw3Bf
	 7YtTEh7dkpCV2Pl0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af14384691-6042b;
	Mon, 09 Nov 2026 11:52:36 +0800 (CST)
X-RM-TRANSID:2ee46af14384691-6042b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.19] (unknown[223.108.79.102])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af14382608-803ac;
	Mon, 09 Nov 2026 11:52:36 +0800 (CST)
X-RM-TRANSID:2ee56af14382608-803ac
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
    oe-linux-nfc@lists.linux.dev,
    David Heidelberg <david@ixit.cz>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@kernel.org>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Thierry Escande <thierry.escande@linux.intel.com>,
    Samuel Ortiz <sameo@linux.intel.com>,
    Samuel Ortiz <sameo@rivosinc.com>,
    linux-kernel@vger.kernel.org,
    yana06070@163.com
Subject: Re: [PATCH net-next] NFC: digital: fix target leak after Type 1 Tag discovery
In-Reply-To: <179419447430.488859.5809759694387881043@kernel.org>
References: <20261109031832.37642-1-yanxia@cmss.chinamobile.com> <179419447430.488859.5809759694387881043@kernel.org>
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
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Nov 2026 03:52:34 +0000
Message-ID: <20261109035234.47231-1-yanxia@cmss.chinamobile.com>

Hi,

This was found by code inspection. I haven't triggered it at runtime.
nfc_targets_found() copies the target, but the T1T success path returns
without freeing the original allocation.

Thanks,
Xia Yan



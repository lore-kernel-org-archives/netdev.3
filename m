Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448879;
	b=4Qr8yelVCIubGuvw9jau5DkOOis9yBR+g5g0MlrakgJIIfO/+jgt7iYRiwIW73iMJaDJ
	 kd1AgZmHGvxI8vJ9t29JvcOss2Dg0kxKnBGsY0TKHH4hrI879m0mEpRFOilAPEzePXyPB
	 HP7e7WVBvOBdFw5j7bcSAbb87jEeWSdnvrbpTKNxdPqMy+9yMG3fxtEvsLThZZsmI2gF5
	 oQus+YA4UaKVI8FXInuy+54b8htrXTMf0hiyogkJXMigfd73B6GbKyCd8eRnSLORgduad
	 1sdVKcfE73LUc1HAwFKP5GpSoNX5ePU7xr3/XAKSKJ09zYBmjH616wYUD8uKqSh5XTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448879;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=eNzrAPG64MO8y3dz4nUcIDSO0TUhGA8rWGS2CeQQssA=;
	b=HYR3IJztdNsycnu3I3Ctdm70G0Q6HZ0cWdcVrJr30cf+l4ruZ0WmCxiFfVKOdUzo1OFf
	 L1/nWFqyRo6DCQk03m6HKz1tkI8ldAfjw7Dvth6Ciamyg7oe6GpOb/L+xX1G2ZhYHxUoZ
	 W95+bJkEMcs0HGZtaEEnUvMfERP0HJvJ2Zud7L3q4kukuDBfsH7lbVt2Ec+85ATjLdaVd
	 tBnaN2oy8oCqQIHjtPyEZmjrPPU/LkI7wjcjOtiXnCrSJ/jV3+YOai356J6GmpGBkFbTy
	 k1Ou/c8h2pCjI4Lc9z9fcPsfjdQ58nMLr/OlsMh8HhYnbqEX3j3VfXx53hplfOL04JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LOcflsq+;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADBC60A3801;
	Thu, 12 Nov 2026 02:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CADBC60A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LOcflsq+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=LOcflsq+muKs9+YwLmCMZNZAlfc8Y8HYJ4qP+ZswwPcfHb9IZf3LGQqYgqROmRlsSIzKFyIWbgJT+
	 DBuOnLiLMYAzY0JA6/C5KlJzULPVADIT4+4nHgd0LAFrT9tIsBJ0DBUdjLhkUGECRCwrm+YNmmAjEd
	 H+G6ZFN6hyErpokA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af51dec2c3-e16c3;
	Thu, 12 Nov 2026 10:01:16 +0800 (CST)
X-RM-TRANSID:2ee96af51dec2c3-e16c3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.64] (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af51debf03-ee564;
	Thu, 12 Nov 2026 10:01:16 +0800 (CST)
X-RM-TRANSID:2ee56af51debf03-ee564
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, asml.silence@gmail.com, kaiyuanz@google.com,
 linux-kernel@vger.kernel.org, almasrymina@google.com, yana06070@163.com
Subject: Re: [PATCH net-next] net: fix token index wraparound in
 SO_DEVMEM_DONTNEED
In-Reply-To: <avTocmy4u8HH0Yo0@devvm16445.scu0.facebook.com>
References: <20261110120331.13661-1-yanxia@cmss.chinamobile.com>
 <avTocmy4u8HH0Yo0@devvm16445.scu0.facebook.com>
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
Date: Thu, 12 Nov 2026 10:00:08 +0800
Message-ID: <179444880814.535319.10275603515600207990@cmss.chinamobile.com>

Hi Stanislav,

You're right. This doesn't fix a bug in valid use of the API.

The intent was to prevent an invalid range from wrapping around and
releasing low-numbered tokens on the same socket. That would make
invalid-input handling more predictable.

I'll drop the patch and won't send another revision.

Thanks,
Xia



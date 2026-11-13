Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794550044;
	b=DfuyjauSw8p2d73d0k7iCZ8aIa9ZPiPETwVFZkSNii1psm3rMFwrVkA5VjT0Bt0jYFi2
	 sO9dLU1no3DCYeUa/x+Ww7Kc6BcL69RF+Wj+23W3oruYEzJDurziFJgk/HjGw+sD06Ff2
	 M3OMmmxDJMmPkMZpYTRCdTdpry9gFbTy4o3MFZoRe3d6cpr0TzWBYaHQ2a6wF1VGvDFNc
	 3Nk0tRO4tTiqDv0UZGnMOAuCbayExg4/cAJkLFqs7cV5zm1xr2ElidixnJEOui84EyOPR
	 IzNIEpbyJLgE6rFLXsOMuiFZ2fpi5m+ogRW6LxdNP3tZJErPzUGrA/5usaOmwpI7zmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550044;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FhIKU1wjENlGQlGcymkf/mmwISHR1yvFia7rES1ePIc=;
	b=u7axu1rp3Df/11oFqEkNcEHNwzLmdZvg8tp51M0H03lYbP+PbDjBhlXX9xJIWvmoqzHg
	 ZYEjqethI67JuncSiTQhLqC5bdbBxmioM2haQCxLy5mkR5vyOaGARrUm/LY9RMYgkTzAJ
	 aC7WH1Q+VN8x3L4YBbiL+EwXWeoRKSOoBRDgW6fMEeDt8tA3NRYO6Firj4vvxlq5xwbG7
	 p19R0sdW5FbXprDocjHgIo9n/tot0XgZv1ssoARyvKbV5ipEvKhjNKQt7ljH0Wx16fvYv
	 2gH2ZZNT/pu0P9gUdW9dGihuCRI6hKOAVaWup6P4NqvAOUSo8W1w+UEej5QH93pLbrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Bxtq15RB;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929F3606A31C;
	Fri, 13 Nov 2026 06:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 929F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Bxtq15RB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Bxtq15RBbZxtxK77YIg9EPno1cEfqAwLysaaipaCa+YBrJmvgKWsIvFMdunX0RBvs04EgA5AATG4F
	 LH00sX+LINOADyX9c296LWeBP7exD+1FNcpAJBNKjPZzR4jG/GCBqS+ZG94ltmJeRmCcreaoCe/An5
	 v1jKCC0g2T4hppuY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af6a9117b8-e925f;
	Fri, 13 Nov 2026 14:07:13 +0800 (CST)
X-RM-TRANSID:2ee76af6a9117b8-e925f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af6a90f2eb-19f4e;
	Fri, 13 Nov 2026 14:07:13 +0800 (CST)
X-RM-TRANSID:2ee56af6a90f2eb-19f4e
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: Re: [PATCH net] amt: handle all upper amt devices in amt_device_event()
Date: Fri, 13 Nov 2026 14:06:55 +0800
Message-Id: <20261113060655.79924-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20261112105135.1ee728e4@kernel.org>
References: <20261111061535.189769-1-sunwenbo@cmss.chinamobile.com> <20261112105135.1ee728e4@kernel.org>
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

Hi Jakub,

Thank you very much for pointing this out. I developed this fix on an
earlier kernel baseline and missed Omar's recent commit 7262e999ebec ("amt:
tear down every amt device on an unregistering lower").

Since commit 7262e999ebec has already properly resolved this issue, please
disregard this patch.

Thanks again for your time and review!

Best regards,
Wenbo Sun



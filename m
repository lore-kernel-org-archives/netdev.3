Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCD1A6815;
	Fri, 10 Apr 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801869; cv=none; b=f4sCQlFrHiJQqIckmrPwiOEQbtaiqabx/qJWiIDss5pJCvC+fOQF/3JL3GNMjZqxQTT548V291zcxs3RGlDRKXwbwh/+viUe00PPD5fC0MucLThzLS2U0BuHiVpCVxiI4k74IowezT2g0ztLBxrPek4ATjZOFFqGqDdJ5aQkLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801869; c=relaxed/simple;
	bh=ZIMFqQRGFEoK/xMFC3XhpI3nYdTkwa3+DAIL83BvR4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ErOMmn/1HfJFQ4SLruUVJLj70k0M1FhCrAwfo0BSIDzfMd88lHn4oX7kuyHOkt+locis/7m1g7ZbTfJRXR1iH4jN7s6mSNVAOpuE+3338zOlLBq2euZuvxCsWmswQrqonO37oVslQmkBElaWWr+zVlgjRjXUSaQsV9R5bRJp5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DMtPVbln; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DMtPVbln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZI
	MFqQRGFEoK/xMFC3XhpI3nYdTkwa3+DAIL83BvR4s=; b=DMtPVblnLyBta20IGk
	vxIcHWSQLFlfXhH2LCqE/drz3FQNT55qY2zfAEX+hJJBwOpDO+Q6yJbH7tWVXhvu
	JrxhQ22NaK31v8KtN422YYro60ggG5AJNKgWd19lUs2gcvVQpZuRgAaU5UyjKN0F
	M11CHPpXESsShJDYuSIg5GVvA=
Received: from YUANZM2-F4WK0J3.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3B_nhldhpioNMBA--.57048S2;
	Fri, 10 Apr 2026 14:17:06 +0800 (CST)
From: wit_yuan <yuanzhaoming901030@126.com>
To: jk@codeconstruct.com.au
Cc: yuanzhaoming901030@126.com,
	yuanzm2@lenovo.com,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Fri, 10 Apr 2026 14:17:02 +0800
Message-Id: <20260410061703.3547-1-yuanzhaoming901030@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au>
References: <ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3B_nhldhpioNMBA--.57048S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUE__UUUUU
X-CM-SenderInfo: h1xd065kdrzxtqjziiqqtqqiyswou0bp/xtbBogIuOWnYleIvWAAA3G



thanks for you reply, jeremy.

I will change the identity.

I also modify the optimized code.


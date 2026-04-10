Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D10386C3F
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802828; cv=none; b=CP/MQ2Jp9NDK8YFHmNvFgTUGb8uVHyFYDHMIl1R+fk4c7rwhpIjhndZIC8TlB3pa+hnWDnDIInKs6l1re1kFv8/hcMlmYCEBarqgmE/9JKverkOWdwMPMl5SjkCtu8J69xoNCAy/TGkirg4WBJj1vA9aE1elHRmmTdxJCCaHffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802828; c=relaxed/simple;
	bh=ZbrZQx8lkV+gKf7k3zFsSPYsl331L3D+ld56c5jncLU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ht+I2XAwA0/91ifsiRga4A8+0KHTkyl1qGHxKPZSlcnRv7NOXbMwpwrLiMj+Tas+EMfeLFSx5Gm+fBgTKLejWR1uP9jif5IYW4sayBTGIvpXiFpTegdAAsOTdn8qaF5G2NnzveAfJIaj4vnOWNPK6kUS/qgytTqMTNWWvc4oPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=GrCv/tBH; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="GrCv/tBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Zb
	rZQx8lkV+gKf7k3zFsSPYsl331L3D+ld56c5jncLU=; b=GrCv/tBHJeEAa9IeBu
	B90DaMRgs8v0SF573fqYOeqPLI3zCafetYum0sE6x4rf9qGmqeQ7zsrsMGI4j/kZ
	AATAx7kNLXOrgke5BUmN1HghPTrCt034JoItG6R/NvH8zsdcnAIVh0S99bRLq6Ic
	EFmYIL31yOb7tagnQZRv5GXSk=
Received: from YUANZM2-F4WK0J3.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3fxq_mdhp439QBg--.60348S2;
	Fri, 10 Apr 2026 14:33:36 +0800 (CST)
From: wit_yuan <yuanzhaoming901030@126.com>
To: netdev@vger.kernel.org
Subject: 
Date: Fri, 10 Apr 2026 14:33:33 +0800
Message-Id: <20260410063334.7531-1-yuanzhaoming901030@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410060957.1336-2-yuanzhaoming901030@126.com>
References: <20260410060957.1336-2-yuanzhaoming901030@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fxq_mdhp439QBg--.60348S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0iihUUUUU
X-CM-SenderInfo: h1xd065kdrzxtqjziiqqtqqiyswou0bp/xtbBogAnMmnYmcBYGgAA3d


Please ignore this patch. It was sent by mistake due to i'm newbee.

I will send a corrected version shortly.

Sorry for the noise.




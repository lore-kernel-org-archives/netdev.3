Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82B331A56
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369297; cv=none; b=r6xG1WUfo/+Q2Cksn5WgTIWaaBY/UOO0+8xEMqSfG54qtBLbHDW8/3Q9Vk2UhU4DX7S1aC9UEjzcvU+T9cA4SbQAwSJcwcFQ5gHKysykYImD0GtLD0wOOrXV4W3nJUuYOL7BjxpqCMywlWak53ex/FER9ynCWlarqI/JSr3tdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369297; c=relaxed/simple;
	bh=KD639c6qmMAwI9AcMi+WpXp9ZZpEKiKIKB5NVvDbzl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gewjoCNe5vZ/w9WElNBu0LMsPB/29vYUCb00F/XYvsKpC2uMoV8L5HT7bo/vw87GfM8BFqBkgXMGaJNTniP5iCe3g61u9+s8qHP+DnlToV++mIlC/SU1DjeCKR10VuNkST80pPpk13su8yW/cNksYOhZ7/hkBbCkallMNsNDPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QMPW/RPK; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QMPW/RPK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780369284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KD639c6qmMAwI9AcMi+WpXp9ZZpEKiKIKB5NVvDbzl4=;
	b=QMPW/RPKGz+ozun+/dNRDKdCfPalp9eYP2dJ4dUjn/TNltp/Q6/Sbi8FW9NSYuQhOFpHic
	Jnthpp1wsa3fjYfpQXBQ33p2KnIcBn/yJtYLbLkbIH2bd2Q084c20hK4hqF7Sto3/FsbbW
	UgZ5jsixZsqWFlMCzcapOBjynn/vXZs=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size in RX frame
Date: Tue,  2 Jun 2026 11:01:06 +0800
Message-ID: <20260602030108.560-1-qingfang.deng@linux.dev>
In-Reply-To: <CY8PR02MB92495E274D4194CF06B1048783122@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com> <cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 2 Jun 2026 at 02:40:13, Selvamani Rajagopal wrote:
> But strangely ptp4l utility failed with invalid data size. Once we removed FCS, it worked fine.

This is because ptp4l misinterprets the FCS as a TLV. There are already
several discussions and patches about this issue, however the maintainer
insists that the ethernet driver needs to be fixed instead:

https://sourceforge.net/p/linuxptp/mailman/message/37858618/
https://sourceforge.net/p/linuxptp/mailman/linuxptp-devel/thread/20190205170652.476c9676%40redhat.com/#msg36579297
https://sourceforge.net/p/linuxptp/mailman/linuxptp-devel/thread/CA%2BDf%2BjcRN98GpUi%3DF_4Ls7miEPbUZYb8O-gpSw0TQoqczVqMfw%40mail.gmail.com/#msg37858491
https://sourceforge.net/p/linuxptp/mailman/linuxptp-devel/thread/8ed1dc74-bf4c-2f13-4ed0-a70d0c4512f6%40cisco.com/#msg37137818

Regards,
Qingfang

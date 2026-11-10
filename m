Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311433;
	b=41JuYOTXOufQe3GcHuZCJpUgoVY5ijCGeiCjzTqPO/wAyGZezqWBOVFPtkgmnKeq3Fwu
	 /NpPFOQsriprhUhHezrcrYkCsrWLwbyl6jP0P6Zmnlwa1kM9Wtoqh2FvZY+uEVG8GtcVd
	 KIbClwMbzMfF3zeLzFyMZR0CZQ9NcRJIg2i24ppcAWKwqHWOCGv8WYb0JxmUhd39vkFm6
	 YLp7BfWz6tnk1eWRR3nNcndGzj2gEH/y1EmgKz3c+NiZp8X/VWSngiexwHdIjDInGpyOw
	 lRG3y/hCGQtInu5GkGGeudyi3me8tWjv2UXR/nHVirdAmWNUjEkXFA+bO+vxVjXIFjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311433;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DfOBqwPIQYKmwTtPKxLsphORT0HP08rFEeeqeR7A9Aw=;
	b=uMzMJ/GzIMATDLa5OwKQpO1Sg4zcjbqSGLcsciQBJ+TbmMIfhiH22DZlxSQZge0myRuw
	 kbCVtPJbzDa2I0yATyBvcROt0HrzJJGIJC5WhQHO2sz6iz2ECqwN8G4dV+AQDtiDHhs3z
	 gGj+QRRILTOxYvmsYGqd9/EI5kX92rua59TUBGnFoyDSkkmTI4Q/CfPlyluZay0GfFf55
	 JGWF4HBwjwo1P7V3B1iUr0JNRWNne29CjQqbOQS+kNg+YeEBKWYAh2bNNhtiDJiX47B5P
	 PircVXLKTK+gL5EBARQCWgjEEd0VbFnJPg9wBIRLOlYnDP6UKw+4vV4Jpy7Aw46rDJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=oFG8TPY9;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84884606D4FE
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84884606D4FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=oFG8TPY9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=oFG8TPY9xhl1iWxqFzB5YCtPV8RBzCuPBja2OEdlpDts2YY+7MvnnvtuPcq67savkNVCNI0uQ4LB0
	 PcJNxh7AgxpGzV0xeUs4Wh1QRRru5y2/elJDOrsBVccmOyajHrss6XWbwHpRjQgX5J3Q0dEehIX62H
	 zZt013NptpFC55MQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af30501fd1-6f0d3;
	Tue, 10 Nov 2026 19:50:29 +0800 (CST)
X-RM-TRANSID:2ee86af30501fd1-6f0d3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.27] (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af3050486e-b378f;
	Tue, 10 Nov 2026 19:50:28 +0800 (CST)
X-RM-TRANSID:2ee36af3050486e-b378f
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: Jingjing Xu <xujingjing@cmss.chinamobile.com>,
 Donald Hunter <donald.hunter@gmail.com>, kuba@kernel.org
Cc: netdev@vger.kernel.org, yana06070@163.com
Subject: Re: [PATCH net] tools: ynl: preserve non-ASCII string attribute bytes
Date: Tue, 10 Nov 2026 19:50:28 +0800
Message-ID: <1794311428000.8394.8452106224079942233@cmss.chinamobile.com>
In-Reply-To: <20261110033922.49297-1-xujingjing@cmss.chinamobile.com>
References: <20261110033922.49297-1-xujingjing@cmss.chinamobile.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On 11/10/26 03:39, Jingjing Xu wrote:
> Netlink strings are not restricted to ASCII. A valid non-ASCII interface
> name makes a getlink dump fail with UnicodeDecodeError, and encoding
> such a name for a rename request raises UnicodeEncodeError.

These are the only two ASCII codec sites in ynl.py, so the patch
covers the full string path.

I tested both calls in plain Python, without a live netlink dump.
ASCII names are unchanged. Names with raw 0x80 or 0xff bytes
round-trip byte for byte, and the old 'ascii' calls raise on the
same input.

e4b48ed460d3 added both ASCII calls, so the Fixes tag is accurate.

Reviewed-by: Xia Yan <yanxia@cmss.chinamobile.com>



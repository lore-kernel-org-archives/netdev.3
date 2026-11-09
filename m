Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206496;
	b=QGX/BTAWF2w5Scp/dZT9DeAiRb1xjAyJ/e+tlNYfhRqTeqz2OE4VzF8787MQvx2s5H5/
	 wshSinYDpNskLaDOEoUeX/SkI6Hgp66z9LofRd4QCV+4sEdSwdvrdiB8P7CkYloYvJvRO
	 pRNeIQmutJm+iO3OeoQzBZsAdYAOuksTxWjF/Erj74spIhS3Ux4LlgtDTWCLio7vilrw4
	 o7muTIIWUjro00vFyaOeEMOTWEO4B950uxiwrkBd+YnVT0zqheWgWYGoyRgkgrfZmxRXy
	 9pL0RbantakHbPNMFMDFfOtb13o3oQjISVb72ny7boOw7Wy8Tsc7h+4rhsiBMHY0Skw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206496;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b4NG28+Ff2oTIi9k9M1agvKHdqFEhBLZ2FfrsTN1o5o=;
	b=UVYb1uEMTp1jHwLr3XkLJFw8Wc40Fdky7OUq/p6U8V/7GtI3l52bCO1E9mJqzzyzKJid
	 TdOC2evsQLmisAA3lMky4YraAc4wS0YRxmObKonzOH13SJThBFuxPw6Vbw8XzbNf6uMo6
	 fs/Q7DyMFKKFAkubDXiVJx/Qfw/YEgBW4Sz4fBN0ADCO7qEAnks+523cOfKt3BQNqyf9O
	 hLPtEIiKZw0/2FutP96I29edeZbN69JaA7sxXXEBucLZfqp+/HW0o+d1zQoRC0V7j5GxM
	 E3Hjdd6vMg5wa/l6dAOzpKjy1qI1tpmGrRhmr3wjWnIyjXK6kmYRJxbjd/wjWgJGlJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KSGCgNY7;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478D8606A31C;
	Mon,  9 Nov 2026 06:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 478D8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KSGCgNY7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=KSGCgNY7PLDxRTZGYg34RiQ9JuzV8gwR1bXmFef1QpioYhuQoXOZ/GiX9vILwFqnBXukhE6doHEBK
	 fsEMi93sKBulcHCBeyn5/0zmjiQZ+VA8e87QQLu2b9UxPF06n5yPBRDLyC0iFsD87c+bNldauGnHPg
	 UkCk2YrEOIocWck4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af16b1d1e3-9d57a;
	Mon, 09 Nov 2026 14:41:33 +0800 (CST)
X-RM-TRANSID:2ee16af16b1d1e3-9d57a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af16b0cff7-849c3;
	Mon, 09 Nov 2026 14:41:33 +0800 (CST)
X-RM-TRANSID:2ee76af16b0cff7-849c3
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	willemdebruijn.kernel@gmail.com,
	narcisav.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: add a KUnit test for the alloc_skb_with_frags() tail split
Date: Mon,  9 Nov 2026 23:41:06 +0900
Message-ID: <20261109144113.36600-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179419003377.994134.4899199888022081447@kernel.org>
References: <20261108100617.23840-3-yanhaishuang@cmss.chinamobile.com> <179419003377.994134.4899199888022081447@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 09, 2026 at 02:07:13AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Would it help to reference that commit by its subject (or sha once it
> is merged)?

Yes, v2 names it by its subject.

> Can this assertion fail on a system with fragmented memory, even with
> the fix applied?
[...]
> Would it be more reliable to call kunit_skip() when the order-3
> allocations cannot be satisfied?

Yes. In v2 the test skips instead of failing when the allocation fails
and an order-3 page can't be allocated either.



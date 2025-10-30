Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8536A615
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845723; cv=none; b=rvPYTsyR9PXG4XDisBb6eHsUhIvFFexqd1wfB1rMXXIoQj25lRhe3Hp5NLHL7htpP/tu/amuUgfRPVv2stwW1tD4FXDmvQCSgvxWkdi9nwStCXodOf56h9CJ8Fd7usWIA4k0P+CvuV7qm+tbhtszOEwajCINu0hSK5GsTX07K/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845723; c=relaxed/simple;
	bh=FRT/vYvrqKPCA3RAjN4pCZdWJrhybYRyZAourHi6T9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7J4DkOLY3sGGhyHZ0XJwTDo4k59lzfjzxtENbZThe3NTQIw8nsTWkTgQ+hvYESTbn/IVVEO08Vh7TiAdiFTj3asXDYOL/9dRogaiyp57nv77Qu8pfK5J5L3mYVuQKYAOLYyFZv8cxnH7zTe9EqBF2axlgY6WKPZG4tgeYKIVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ekVgK/NI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ekVgK/NI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D31E01A170E
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:35:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9E74E60331;
	Thu, 30 Oct 2025 17:35:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BD68118089DD;
	Thu, 30 Oct 2025 18:35:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761845719; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jFQK5BonPhKmLliFWn8GBYW/cMDoiIIJuQ7p9ZH5BLw=;
	b=ekVgK/NIszW9H8Ajz5JGZibSG8mROzHzfICA9s9F63LRYD10rIG1+LkSgUn3Q+gk0Ydt3M
	x4l2EFKgjU8iA1jPJmbnnViWnmjiELJx5yBKHPbtnOhQ7OFrA84cp/5o+q1yJbjPR/UvnS
	rL2p39eKOnvmOKUFE/qhSKATyT5/o2405VjeEjSfoOC+JFbakXj4lZ2KJLnGuwELF83KyR
	3q839uXFCrDL7we1ynUc/yW0vyS5xKzTasbflpft/+2bA8n/So7wqRL8lQhICzCtZZo6sS
	lkOIZFDIHAXq+VLejuIbxycBBh4iijXf/9Qo0Sqb5rFY3qkmSj1mNhovmBt00w==
Message-ID: <ee5a78fc-5e25-4308-b4f6-3d12cbc07169@bootlin.com>
Date: Thu, 30 Oct 2025 18:35:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v5 4/5] amd-xgbe: add ethtool split header
 selftest
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
 <20251030091336.3496880-3-Raju.Rangoju@amd.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251030091336.3496880-3-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Raju,

On 30/10/2025 10:13, Raju Rangoju wrote:
> Adds support for ethtool split header selftest. Performs
> UDP and TCP check to ensure split header selft test works
> for both packet types.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

This looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

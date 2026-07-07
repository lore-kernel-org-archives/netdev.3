Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCA1B4156;
	Tue,  7 Jul 2026 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388817; cv=none; b=kBiFQaepGwVuZQ3WodduNLaWzKynCk7VRoIcE0OZzylnXoOCnb2s5w2t02eqPryLJPacBqa6d/rTLgzqa71Ydh+0tywoRYU9swkz/xkJ1Zxvc/dodClYjE5Y8S9jtLY9lZAe3oeRM6M6SejABzwjJ0wgbL2vbGP9t9dPgtbuU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388817; c=relaxed/simple;
	bh=bGAaGSbTeVj15Vx8VmsXITVKJKxbdj6+naUJp9y/L4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F63Ww7DMiQWnz91uJGPdYXgtaXlUzhm6pO/NsPrGnxVVhwFunXz6D6d/h+I5qucZceXxXiOY2+MWlCqDPYKTIvTxe8ynMTyC9Vrg9y+E/bG39Ea9EXtDxuTNB8p/cKulMl1ZwXRSB1cdK0sEmQHJNy21cnUuIfoJmkDtW62rMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0003-solos_pci-pw-bot-cr.eml (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowACnAdWKWkxqEGxOFw--.39501S2;
	Tue, 07 Jul 2026 09:46:50 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chas Williams <3chas3@gmail.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: solos-pci: validate DMA receive size
Date: Tue, 07 Jul 2026 09:45:12 +0800
Message-ID: <20260707-pwbot-cr-03-solos_pci-pengpeng@iscas.ac.cn>
In-Reply-To: <8ef7d67f-c47c-4342-a411-4ac126abd757@lunn.ch>
References: <20260705084504.54281-1-pengpeng@iscas.ac.cn> <8ef7d67f-c47c-4342-a411-4ac126abd757@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:zQCowACnAdWKWkxqEGxOFw--.39501S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYw7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUOAwxUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

pw-bot: cr


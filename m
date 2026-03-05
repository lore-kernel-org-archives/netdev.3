Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184CE27FD6D;
	Thu,  5 Mar 2026 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772690137; cv=none; b=ZrnAAyLJpgqcL8DbsJU7U3wg97wLKWYPW6SyCWl9sZ0ruEfCRwaObW99NT0isnugDxVb4GxHADybqy928uTeRXO1vswkJ+fi70ceKgqsRhflvMijoSRfY5wRMEzgo9C/pEGCK8Qt5MxINks0uOA1RXZv7FZpNYkwNH6ce8BYKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772690137; c=relaxed/simple;
	bh=Czx2nGVXa4yCKcFO4p1gXOQDdhTXZs9uyUqa0CQuGvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wl/+U9nbrO4WfWREr0YGeykxC7crGz+RrexFC9eUpIV5pMS3VTGL8sHA/EaFw1zks+pABxlJbPZWO0jOO+kUvloB1xsQo9AVkwenrnX1vnQo+ynvIqrLJbEgABkEiH1dEMF67teCrrWJpYsTOnoZZKjUU9QvmHTjsE+Aq/a0f64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.19.140] (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowABH1Qi8Gqlpj0uuCQ--.59493S2;
	Thu, 05 Mar 2026 13:55:08 +0800 (CST)
Message-ID: <74fd6fda-7607-4afd-a596-b95ca44c4fa5@iscas.ac.cn>
Date: Thu, 5 Mar 2026 13:55:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: spacemit: Remove unused buff_addr
 fields
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260303-k1-ethernet-more-fixes-v1-0-0ab0122fdd14@iscas.ac.cn>
 <20260303-k1-ethernet-more-fixes-v1-1-0ab0122fdd14@iscas.ac.cn>
 <02bbff3d-1f27-4b03-a963-660bbb7facee@lunn.ch>
 <20260304140535.678e65f2@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260304140535.678e65f2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowABH1Qi8Gqlpj0uuCQ--.59493S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWxJr4UtrWUJr1fWr1rZwb_yoWxCrg_XF
	1jy3W8Cr4DGr17GrZ7KwsrJrZFya92qryvvw1Yqr43J34fArZaqr4kKr1fK3WfA3yqqr1D
	KFyYv3y5ur1jvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUgsmRDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 3/5/26 06:05, Jakub Kicinski wrote:
> On Wed, 4 Mar 2026 21:57:57 +0100 Andrew Lunn wrote:
>> On Tue, Mar 03, 2026 at 05:24:18PM +0800, Vivian Wang wrote:
>>> These were never used. Just remove them.
>>>
>>> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")  
>> If you are giving a Fixes: tag, please use the net tree, not net-next.
> Maybe rephrasing what Andrew said slightly - please read
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> and general documentation about Fixes tags. The tags mean there is
> a bug which may be impacting users.

Sorry for misunderstanding this. I'll fix it in v2.

Vivian "dramforever" Wang


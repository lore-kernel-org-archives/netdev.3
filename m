Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006847;
	b=if96/F9bx3KHIgoUUl/Mxq19N3Qf1QbYxGBifbEV4jJq3XOCRFcc9AkGHyIadNbr3238
	 UR3m3bvPDQPWmTocmMyiQ8te94JUDjelwh7LVr6Y+flTi1b+YW43RBAivp3Nl9rSoC/bw
	 Lk0iR93ExsbRtG1qB5nOQJezjxqK4ZRUt/7rEWNkG8uEVX2B231jX6f4UwBpztSLWmqf+
	 Qg6ceF5HhMZBONdttl8RW/I/n3NULrbLPDg8lB+M2+GalCKlebtbE8muDa0q5uA7ZcqNT
	 jK0Z9qX12R8tQ56Cqv/ASpdXQN8sT8AMKkyxnVMBebtWXsWZmeD70P5G2oX6Yq5Jb9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006847;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=UOjH/KZrJevJUFQC3mjbJKqPCVBhF0Dx/9N1xhVblbk=;
	b=JGTkT1HXuaSryQgsEA2f8MlaORdieuMUcjMaf00RGbFBvoZNZhBeAdZPCyrrREgZl/Dt
	 VMOK7g3uZGE+cuYU+hblKo8GsMUF34duAJzx6bD28Sqyysrj9afbjhuiCSnCNA2+0wHLs
	 Mjl+zqcqP6scQ4rKq+dAlQ7Tk5vIiE528PoJPUlhtQkST7myB0we/ybLJctrxJKxEd+/K
	 vr7MGSHqL+zb8HeK1w/YAblAmJGd/GmTdJJ2nHnj5koQ2Ukh1rfpBsRR3yLb9wcqRNb4V
	 miT+95UwDFifOadx/VGt8PfzA+M96p1dOnSpY9q+yglQOCifi+j+7Aik6ySWq31EIMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mucse.com;
	spf=pass smtp.mailfrom=mucse.com;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C03606A31D;
	Mon, 26 Oct 2026 09:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C03606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz9t1793006777t9d6df4ad
X-QQ-Originating-IP: h+ap49Kv0RfW/vllUVPU9/sQGgdKAP75oz8+M9g7oj0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 Oct 2026 17:26:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10730358307232006467
EX-QQ-RecipientCnt: 10
Date: Mon, 26 Oct 2026 17:26:15 +0800
From: Yibo Dong <dong100@mucse.com>
To: netdev-bot+sinfo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net] net: rnpgbe: Accept link-down events without speed
 magic
Message-ID: <5A927C9600407C98+20261026092615.GA933559@nic-Precision-5820-Tower>
References: <C2DFBBF04F1DCFD2+20261026075445.920572-1-dong100@mucse.com>
 <179300162296.3327.8577140950893281339@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <179300162296.3327.8577140950893281339@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OTaQrRjuGKLtxOvFOOK7L+T3iiOch2ydc8sfENvqMAnF3LoslTUJeSMi
	8mNKcpgPJ+MAKtIDpkdAbf2apxk3ly5z4O6fAlxXI6tZo51VNFhYpUCqB8VsOL9OOfcCz5d
	NW6LWFfrFffArtjVzgMDfhAlyyFxmhebYmTELdFIzk7Rq+W0385UfHoIOjro0ZRZq3uXtT+
	b9W/A939WqplwdVpkXCCJuI1ZiL1zld3nWSVhSLSTttSicpnmWqWDLMTQd2aCql0IjhE34Q
	yfYaUo/BSTQdoXHcFlDbjBGIH6nPCAmE/UWIlbuyO5NDj8py+hRTVxUEXr1QM9AIdSMTBdb
	6Le+zrHtMwkD5758kkuwFOxjX6fgfKZOJZoMBi8DKWYiWdg8lOL8rT/kPCnMqEpqeI8K1jM
	Xh24Re4dthAVllcqWdI8xHXblzuwsMJLy+QO0IX4mJ5EmbKpqTIYyz6iH9EwAWRtQJ5krKc
	tO1/iOoq/e2ivlxml7nSz1BIz9g8DzcmQlRJ3gLwBQWUD5fyq1/dZRu27PLhAylnFeWHH3h
	DhhMDcScrbBwWqaKsSnd3AdWzxCeJgwl/D/nfgNSNU5gMY3KnyQjs0VfapsLNTWPGXSVMNp
	EIWDNY2OCpcS3+ZOUqEtBNy+mHeE4Fr3fCdzOzFSQgPxQa9J2GsUj7v3BzK8A0cZGuW4pyW
	6J6KHsCPBWwHpijnlexj9VOPZQAHCfFZXU0WjZaHzhn7hCK2e/KTVIGBNxd+uvaN25dXT6t
	EvTFxgthj3lZueomjOXYK/iqa9Bik3tIgmSKbYBWSDMPzoXL0QkGngiJ2ZJmusZRYC5MFIC
	BljKFOcMhBtfQhkVnOqnoRQrVKhpyGtEh0kwLC9n+Wtn4zefd+ItD00Vjufi5OlyQKsj69A
	GgzMMBKAGh2Ih27B+bwe53p3Q6l6eHwcuFKt5DoEP9+rumUsRiEm60U7d3axXdj1g95+qr8
	WSAD4HOAYPNYMhNtvgTCnZNI2PjnCJ3U8EQutyFyUhXObVrnZ3U5mxMDyKJP7KsZiQmYHAK
	6Ue805myjeBCteyGozinUkMmzjcok=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Mon, Oct 26, 2026 at 08:00:22AM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
> 
Hi,

The issue was encountered during rnpgbe development and hardware
regression testing.

The fix was tested on MUCSE N210 and N500 adapters with firmware
1.1.8.0, using PCI passthrough to a VM. Physical N500 is used as
link partners.

With the unpatched driver, administratively bringing down the link
partner left the VM interface reporting carrier up throughout a
seven-second observation period. With the patch applied, the VM
interface correctly reported carrier down.

The comparison was repeated three times per adapter for both driver
versions. After bringing the link partner back up, bidirectional
ping passed in every case.

If another revision is needed, I will include this information in
the commit message.

Thanks,
Dong Yibo

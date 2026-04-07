Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCC1DE8BE;
	Tue,  7 Apr 2026 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527587; cv=none; b=dvFdiB0lmLK4p+mGfN2iPNMfwC/Q9N+gXm9bUoL88cAwmRxjooRaRN2vWUNoUTPxgN4QjA5nC8hkx+U9X6w6MkrQfSRqOPgpreYaCqJE+dEwm8luMZ2WZHOHTtWyjNdWAsZEYXilw6m0cFKOQiSsBlza4Ulzq53tyxR5JBpP63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527587; c=relaxed/simple;
	bh=+f2UOPImH35g4Dc44A84oU2dmZHo2HxTfwAD8Wjygko=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6Mnecg3JR3w9xpA1AqJKWRC/5ahlVxyv6RV97usj6e9yGKpj/6SuZ5Jx+mcCGTMUBmMwPNxPKIet3/DRvgVxhesG8Xp2Wx/Spqg8+cqUfbAXm262vCQcG2g9EOIacFGVoPj5FgPbckWQ28oEauqeRX+RUrmOxUdVUeQWRrDyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0004-nfc-sensf-reply.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowACnT2uRZtRpHZx2DA--.46852S2;
	Tue, 07 Apr 2026 10:06:09 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Tue, 7 Apr 2026 11:30:03 +0800
Message-ID: <20260407113003.4-nfc-sensf-reply-pengpeng@iscas.ac.cn>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] net/nfc: bound SENSF response copy length
In-Reply-To: <20260322031922.57949-1-pengpeng@iscas.ac.cn>
References: <20260322031922.57949-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnT2uRZtRpHZx2DA--.46852S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW5JFy8JFW7Xw4kKFy5twb_yoWxZwc_Za
	yvywnrK3WDuFs8Aa1xCan5KrZ7ArsruF97GFW0qrn7WryjyF15C3Z3t3savr1kX34jqrZ8
	Cr1kG3Z5CryqgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8
	ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Simon,

Thanks, you're right about the net targeting, the NFC: digital:
prefix, and the missing Fixes tag.

You are also right that a valid full SENSF_RES can be 19 bytes long.
So instead of rejecting resp->len > NFC_SENSF_RES_MAXSIZE, v2 only
rejects payloads larger than struct digital_sensf_res, then clamps the
copy into the 18-byte sensf_res buffer inside struct nfc_target.

That keeps valid 19-byte responses working while still fixing the stack
overwrite in the target copy path. The lower-bound check remains on the
pre-skb_pull() frame length, and v2 only adds the post-pull upper bound
before treating the payload as struct digital_sensf_res.

Thanks,
Pengpeng



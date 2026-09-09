Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15564A91
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915205; cv=none; b=cmdWcMIpP8qKstkx7QU8Dau8ng76Lny07LifkihAVaIo1UGrQ5MDWNILIye6D53UeBuiY1AJNnxgHESMgpCXanRSHZ/fM7Xk8CH0lC5FaF9BSxtTe+W0dLa5CGHp6yU06jl/7Xw/c2cPl+9ozt+gME0igfGET1cJ+2jDLzWrNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915205; c=relaxed/simple;
	bh=fqh7lKtfEXxk7MisOpbuw4cS0wuLML0lccohR431yTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pedxvN6foL3YmEkyljnAX7CwxrrsldqQOCasYBNhbyp4HT4ulk9onBrInO+WaORjzHkO1h2q+EIRw4qwoM9FCWbCKMZJxjclR1nMN6q5DJ4aAwZuCbknbn2GUZXEqfPbky6h1auhB1JUJodu/DILgf22889oTaPeUxiO/Vc9XTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYuAuQR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYuAuQR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EA81F00A3A;
	Wed,  9 Sep 2026 00:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915204;
	bh=AkoDS8q1Aipl/AeEQsXneftZ36JxnRn/nh/2Ei3PLJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FYuAuQR2qSATMZVrtC27Y0+08etJkPbDPL5J8JYg1K0RqgyWFTXWJPJjoKFwJOUPA
	 cTj7cJniXxC+47hdacyK0SukgJM0EKSVMAl9uRVx35m92PtSff2sB1tHPbbnzLcTgm
	 nzmlX+oTTdQSyEupMN8CXtlzIqwup7lTKHI/UO0PZ0Mdsrv7XMy4Hqjtorhu4hpxwH
	 jtW/1J53X2O7ODF0kOGAZnjFd2WEA11dvbH0nluN0YE4lSjST4yB8HuiPo0epTMBrR
	 Lzj19XkVDh9QxW+kERZfEs3s3oChem/PKPVMVBmn172rU4kbEJDFXi9q218pd2VnT3
	 njwobC+6CaLhQ==
Date: Tue, 8 Sep 2026 17:53:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wong Boon Jhee <wongboonjhee52@gmail.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com
Subject: Re: [PATCH v4] net/ncsi: Fix Use-After-Free in NCSI channel and
 package removal
Message-ID: <20260908175323.3cb83f5f@kernel.org>
In-Reply-To: <20260905145902.345090-1-wongboonjhee52@gmail.com>
References: <20260905145902.345090-1-wongboonjhee52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Sep 2026 22:59:02 +0800 Wong Boon Jhee wrote:
> In net/ncsi/ncsi-manage.c, ncsi_remove_channel() and
> ncsi_remove_package() remove objects from an RCU-protected linked list
> using list_del_rcu() and immediately free them using kfree().

../net/ncsi/ncsi-manage.c:45:16: warning: unused variable 'flags' [-Wunused-variable]
   45 |         unsigned long flags;
      |                       ^~~~~
../net/ncsi/ncsi-manage.c:906:8: warning: variable 'flags' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
  906 |                         if (ncm->enable)
      |                             ^~~~~~~~~~~
../net/ncsi/ncsi-manage.c:941:37: note: uninitialized use occurs here
  941 |         spin_unlock_irqrestore(&ndp->lock, flags);
      |                                            ^~~~~
../net/ncsi/ncsi-manage.c:906:4: note: remove the 'if' if its condition is always false
  906 |                         if (ncm->enable)
      |                         ^~~~~~~~~~~~~~~~
  907 |                                 goto out_false;
      |                                 ~~~~~~~~~~~~~~
../net/ncsi/ncsi-manage.c:894:21: note: initialize the variable 'flags' to silence this warning
  894 |         unsigned long flags;
      |                            ^
      |                             = 0

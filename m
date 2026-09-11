Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF633F59A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106953; cv=none; b=bSb+6mu6NfzrQ0FmkVOS/rXC6v0i+bkik6oLw4jVGdPYFs2kRaWj/nSQEDW97RjRoTexbJ1lG+LlnV8SzL1L5e3tzE6E9O+R2y+8/xWYqvrIExwnAFMTVwl6rKhtQfeUNAF7F75uNzlT0qIH2z+DD0xukXXqIx3Zin621Kp03l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106953; c=relaxed/simple;
	bh=+ERPeB41djCwcZTPge/o1vUGuMu2BU+QuVJ8NJ/2ls0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5uOcYOzj8IS20xDsa+Me2Iiy0KGai3CjpG3ivxec3JEnyXlEo9YsObn/xLw8L6qFfxUV5yqVOckuX/7J4EbIeVhlr7Ub/3ERADTPUYTsHTbj7vFeqHZbz2P/1EAo0vpK8wtwZl00y0y7LZ6QYrYM6YEksLm/QjhStN7oClrx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IIcuX6Ax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IIcuX6Ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A02A1F000FF;
	Fri, 11 Sep 2026 06:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789106952;
	bh=+ERPeB41djCwcZTPge/o1vUGuMu2BU+QuVJ8NJ/2ls0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IIcuX6Ax4nvehWS/H2k/QkpPkGeyhpgDpYrDHn1C5ZCx8DU810+8JDVVpJ3P95L/K
	 VpwAiy1DEadTvIlvoKoNFM3HD9CH+FZI7Js6/5Z5fwmkjfRvquKQ6Iqb1DVnnMnmmF
	 ChEuHsbSg/zEThAw801LY12nTTvh4E89UK691itA=
Date: Fri, 11 Sep 2026 08:07:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5p2O5by6?= <liqiang35@xiaomi.com>
Cc: "security@kernel.org" <security@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net/sched: taprio: fix infinite loop in
 taprio_dequeue_tc_priority()
Message-ID: <2026091102-shield-underage-ebe4@gregkh>
References: <997210f347bf47b8b2644df8c4331594@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <997210f347bf47b8b2644df8c4331594@xiaomi.com>

On Fri, Sep 11, 2026 at 03:37:14AM +0000, 李强 wrote:
> #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#

Now deleted.

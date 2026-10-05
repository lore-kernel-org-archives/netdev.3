Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BC4C041B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213222; cv=none; b=TlHva1ycYtDq6qnvJvFDGF9Rs6dS9wx4kDCfOrCTfqRT4Yd9/U+CAZsuRig/ZkhavXB2HaBsXk8boJBLBOHaC4wOLGK2UuTipHOGd0NJh9QJjCGwwV8jVphcnFZZj9vQOvkBMqDwcLcDEsUvASWHAKVSKRWlO5XgX2lyevZToAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213222; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p9x7+AEQp6fEPcyjuLvr9fXu4VZSaYXzuEYlXyTT2ErafgrpGwV3ipeU9iVxgh9LSSItHJFGY8lUIkWrHx+vuhpziWzPA8YQRK2ypYesUVrd74zPC1N58igoM3B2HOGS3RYVahxW/d2VU8SSM69Q3CVFBZFjf3IqEoo0OlJVbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIBp6QoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIBp6QoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D081F000FF;
	Mon,  5 Oct 2026 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791213221;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bIBp6QoNNPp56zE6N/X6/58VyCFsNR2NETKLoOHdegSHo1OJNvj3Bv40yMbTh4rQV
	 e5jmRDEXP4dluvsDNsW657iznFKQVbXANp1Lwd+YKUbQi66+UgWHS+VgX9i8HIokP5
	 AHBJ6ySHVSl8qrOyFnbeHHHgrEbc+W9sekzkIQj0UBDJ2MeMXfTBfVcyoh9bi9Xiz4
	 e8PFB22B8tPaSwyyMi9HT2+FfKeXItGf6vguEmXX8dtRakRGW+k7Wy/UKCqQfkmAzE
	 DL3jNHVawdKDH0X2JSJHqAw+HaHVfM/sX2EJTmTSIyoxrNzPidbt4Wna+VbleVWAH9
	 l5L95Uwon21HQ==
From: netdev-bot+sinfo@kernel.org
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, blp@nicira.com,
 joe@wand.net.nz, jesse@nicira.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net, i.maximets@ovn.org,
 echaudro@redhat.com, aconole@redhat.com
Subject: Re: [PATCH net-next v2] net: openvswitch: do not set transport header
 on later IPv4 fragments
Date: Mon, 05 Oct 2026 15:13:39 +0000
Message-ID: <179121321982.1402591.7112090306604732381@kernel.org>
In-Reply-To: <20261005150831.4831-1-fmancera@suse.de>
References: <20261005150831.4831-1-fmancera@suse.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

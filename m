Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352883B52FA;
	Thu,  2 Jul 2026 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983424; cv=none; b=fMuGaK8MNsKj+bUiTEXwKYSIGcXicOD0jEH3Y+OTXwj+kkCo9P//K6dzOdLepoSI7sgggOpV2LksOH69ehbg8YbHcO8eTm7a8SUyy9xgQWmtgR6iXINkslm1igknv09ONr9iAfXYUbpoRNWcOA0/XGr7whbNxkYknRizjsCvANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983424; c=relaxed/simple;
	bh=f0HIP3us4SwozEp0bJcD/ng4r23uDIDIXGDEEW2IdFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nwiy37H45FbhTxSaCWvC/TySJlqhIVjxM9gvd48bmQNxXSj8gsAMatD4rVrI5PcJrHXMLbsucqL3tfH9nmZQxsINe5LCY/YzjhEvGTHntzQs6O+RQETQsBZUYQRNNVtVa7o5vZyrptciDFuSP3z+M+48C3IHJdK9Lpzx67e7n6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFWMmVpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFWMmVpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EE81F00A3D;
	Thu,  2 Jul 2026 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782983422;
	bh=Rs9tTgl5fyFLDqt1jibTXsWudB6xaSrmbkriQUZVpWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fFWMmVpCL9pj3uETKXxJ/vRkWx70UXN9E0XzGIdB3XirLY14URJi2rAgBJARFIkIH
	 UF4M8YFa4CmM5H3W9G5/xAgH7Fdpbz364/QnW1nbetuUBSngzKRj/thg64COdEF8Z2
	 d+84aa9LK0xhnzmEW2L1pHyiiS8vv2SPrgt+B/6mJ+3aCQhnxjxl6rjju61OpZ1MId
	 rgGyd9Czc7ug0mBGsC9bTwDsY5D0/nwKGWIfabGpgE0k8UPZMhHppcRDBovc2BsjNO
	 1iSfAvv7jVTczs75Ac74Q/e7f8pYP4ssyEV1/TOj1sZWuGq5no/Lhzoxa4xFrapLhR
	 i28FSSG1/r/rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B5B3926665;
	Thu,  2 Jul 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: usb: rtl8150: handle link status read
 failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298340589.1537313.17929196143531791690.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 09:10:05 +0000
References: <20260630101216.10365-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260630101216.10365-1-alhouseenyousef@gmail.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 12:12:16 +0200 you wrote:
> set_carrier() ignores the result of the USB control transfer and tests
> the stack variable supplied as its receive buffer. If the device rejects
> or aborts the request, that variable remains uninitialized and the driver
> chooses an arbitrary carrier state.
> 
> Leave the existing carrier state unchanged when the link status cannot be
> read. A transient USB error should not be treated as link loss.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: usb: rtl8150: handle link status read failures
    https://git.kernel.org/netdev/net-next/c/8c9c5b9a6896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0132B9B5;
	Mon, 12 Oct 2026 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795740; cv=none; b=upzY9TyFzoVrZurWnRTPzUXqyrK9m6jrEpAdrbHduzmUknSAC3BubgKqzc+yguPVeHW+f2aJZ83ulXY85MJYsw6j2TyJXmLFgHHywQMxiSinj5dA5ETuLhLp/Q6TxWNR+iRG21f0CwnLXMfSWk8bzb8YS4t1dqkoP+dMl29CS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795740; c=relaxed/simple;
	bh=SB2bZai9ebVlfeIEu1FPnR3qKYYYhVG244XU03adJ4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5SudAv0MRwtdUdvjy+o6SbcNKt4AXIOnCECuuebxcYH29HY+c7NaLW48BbRi0MT1JynwkDA/CL7aN4mkKOgWKQtXmMXdhJP6yqqHmXU47J4nBBoyaxUxMZMYzfboeeQNm9MWNRNWAlElQX7oIIEebpnt6Gp13RU9Tjmfpguzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=RQkZDe73; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RQkZDe73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=KFxI/qq+kpw+3Ln510VqxPWXh5UrKdc6BHt7MxItub8=;
	b=RQkZDe73x2t4ySLUJ8FUpjBas02deBlTBlx6Jd7p7Q0gSTSEyHPRlwF+JVqeUS
	ikHOTCCwGV/Hq3styQwibtKLQz1gu2tH3C87vvaqMCtbzTxW+rWLD+WgtO44oRhJ
	i6s7TeO8iWwTEiondVXyrh2IyiZ8UE183TiyRaL3gfOiA=
Message-ID: <df018b17-ffa3-47cb-a259-55a9d1133e93@126.com>
Date: Mon, 12 Oct 2026 17:00:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: do not report success for a VF setting that
 was not applied
To: netdev-bot+sinfo@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261012082910.283229-1-xiaolinkui@126.com>
 <179179405801.2527009.14010952920802573492@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179179405801.2527009.14010952920802573492@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD375ikocxqYLrEBA--.58567S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFy7AF47uFWkCryDtFyUGFg_yoW5WryrpF
	WYkan0ya1DJFy7Kr92qw4jva4S9rs3GayDWr1rKryUAwn8KF1ayrZaqw1jyasrC393u34S
	9rWDXw1DZFyqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uuv38UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQVfNmrMoaXPIgAA3K



On 2026/10/12 16:34, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,
Thanks for the note. The automated check is correct; the commit message is
missing the hardware-testing information. Here it is.

This change was not tested on real hardware, and there is no Tested-by tag
for exactly that reason. The race was found by code inspection of the ndo VF
handlers; it was not reproduced at runtime.

What I verified is limited to build and static checks:

- ice_sriov.o was build tested only, with the native kbuild command line of
   an existing v7.3-rc2 x86_64 build tree (gcc 9.3.0), both with the normal
   -Wall set and with -Wextra added. The diagnostics for the baseline file
   and for the patched file are identical (zero), so the patch adds no new
   warnings. The only new undefined symbol in the object is
   ice_is_vf_disabled(), the helper the patch starts calling.
- checkpatch.pl --strict: 0 errors, 0 warnings, 0 checks.
- The patch applies to e04de0215596 with no offset, and at the object level
   only __ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan()
   gain an ice_is_vf_disabled() call; no other function in the file is
   affected.

I could not run it on hardware: reaching the window needs an ice PF with
SR-IOV enabled and VFs assigned, plus a PF-wide VF reset racing with a VF
configuration request. The reset side is the ice_reset_all_vfs() path, i.e.
a PF-wide reset: a PFR (ethtool --reset <pf> pfr is one way to ask for one)
or a CORER/GLOBR/EMPR completion. The other side is an
"ip link set dev <pf> vf <n> mac|trust|vlan ..." request. I do not have
access to such a system.

For anyone who does have one: on the unpatched baseline the visible symptom
is that "ip link show <pf>" and the VF's devlink port report the new setting
while the hardware and the switch keep using the old one. With the patch the
request should come back with -EINVAL instead of reporting success. I am
happy to run any specific test that is suggested.

No repost was made, as requested. If a v2 is needed for other reasons, I'll
include this information in the commit messages.

Thanks,
Linkui


Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B03B0ACE;
	Wed, 30 Sep 2026 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800401; cv=none; b=u8EGu0c7BurTEtc71JzGybtFwhujq+fZDDKYuUJ6H2BVRCejAQk58HE8+yxc8MvmBD8nWTjwoUyEd9Og4D4dk5wjo8D+qHMW1CJg/ImubqV5rlaW+NwVKJxjrVKgWzlqno6TsKiDm5He8R+cSOk4XaXO/kqWQfoaLFMrAbzvbV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800401; c=relaxed/simple;
	bh=PylNs7iCHR5pCSs6TpaJvlXtvey8yTCsX54apfw4ljg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nMeYSdpkqWfFmrJpU/39HgZ3h0rGAxAbJh8Z2AT7aAE0RmUZdhMJX7yf9IIA44r2Fet1aPmqrJLHcJGq0qjYX2chvv5q1KlEbhJMHHzw7gqaVhb1rAu9IjfQ1CdLecl3csru10Qa27YHKfNa4c0Za4Y1UqXUyC9HLZVmTOGYShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pYAC+Sat; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=83v9ub6H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XGws/ED9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GmAxat6V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pYAC+Sat";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="83v9ub6H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XGws/ED9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GmAxat6V"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D4051FB6F;
	Wed, 30 Sep 2026 20:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790800393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpTzfJn3+6XWbhfY1AADO1Wk3w09l39+adOgbm51IvQ=;
	b=pYAC+SatA33ZS3TZNsPdoK0Fq0mE6JSlS8ZOFOrJsqqjled4xdQw54GB/Q0ZyOS5WCR9xC
	/18gYNwgor6tGhglGftMYXfuaqa4e+RqdW/pFIHz8Bi8rWqDizX+uVAeMXN0bxFDJVvnZs
	O2gKvfWmbAPbu+Lo0h88Ec57+rwT8ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790800393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpTzfJn3+6XWbhfY1AADO1Wk3w09l39+adOgbm51IvQ=;
	b=83v9ub6HI4e+Ulj5NHLQNYfHwIzmwjElrfVMQRscYtShVEeA+BJhRwAbz19pCkOVmy2zRJ
	XNbZgYv3I2rkaiDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790800389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpTzfJn3+6XWbhfY1AADO1Wk3w09l39+adOgbm51IvQ=;
	b=XGws/ED93hPv9zOqXn4riXoWcrVjEnxuqsU62bz01QroejMgebFuC+VxRMwaJnUZ5kwZAx
	1+LTCn7q8jF9XD0mjuZuj/bAz0l/SS0BFIfS/0sMhWEIMmfRjnkOF4Ul/On5RGjjc4lCB5
	yzM0/zCcxynGVvDtGweV9BZJDm+PIt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790800389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpTzfJn3+6XWbhfY1AADO1Wk3w09l39+adOgbm51IvQ=;
	b=GmAxat6Vnr8V4FqVcYUtzEWrbvZa9M1pv7cuvEVhYwB7ClcFFYFB8b4WHM/eFR8dDCw6Ll
	cfz91j6ChmmvnNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85BB413B1E;
	Wed, 30 Sep 2026 20:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xBSUFwRyvWp+eQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 20:33:08 +0000
Message-ID: <f55e4910-9d05-43df-b8a9-370234aba7d0@suse.de>
Date: Wed, 30 Sep 2026 22:31:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [openvswitch?] WARNING in set_ipv6_addr
To: syzbot <syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com>,
 aconole@redhat.com, davem@davemloft.net, dev@openvswitch.org,
 echaudro@redhat.com, edumazet@google.com, horms@kernel.org,
 i.maximets@ovn.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <6abd40af.fac9d4e5.17396.0008.GAE@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <6abd40af.fac9d4e5.17396.0008.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=88147dd7e4cb6a0f];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[4cc63fcfb3845e149969];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,appspotmail.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

On 9/30/26 7:02 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    47a144672573 Merge branch 'mptcp-misc-improvements-for-v7-4'
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1342db25580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88147dd7e4cb6a0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=4cc63fcfb3845e149969
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c35e05580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11908035580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/974586b80355/disk-47a14467.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/05ff7f1eb7cf/vmlinux-47a14467.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d63ff990e2c6/bzImage-47a14467.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
> 
> ovs-dp0: entered promiscuous mode
> ------------[ cut here ]------------
> !skb_transport_header_was_set(skb)
> WARNING: ./include/linux/skbuff.h:3075 at skb_transport_header include/linux/skbuff.h:3075 [inline], CPU#1: syz-executor463/5635
> WARNING: ./include/linux/skbuff.h:3075 at skb_transport_offset include/linux/skbuff.h:3250 [inline], CPU#1: syz-executor463/5635
> WARNING: ./include/linux/skbuff.h:3075 at update_ipv6_checksum net/openvswitch/actions.c:361 [inline], CPU#1: syz-executor463/5635
> WARNING: ./include/linux/skbuff.h:3075 at set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399, CPU#1: syz-executor463/5635
> Modules linked in:
> CPU: 1 UID: 0 PID: 5635 Comm: syz-executor463 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> RIP: 0010:skb_transport_header include/linux/skbuff.h:3075 [inline]
> RIP: 0010:skb_transport_offset include/linux/skbuff.h:3250 [inline]
> RIP: 0010:update_ipv6_checksum net/openvswitch/actions.c:361 [inline]
> RIP: 0010:set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399
> Code: f6 e8 12 d3 05 00 ba 10 00 00 00 4c 89 ef 48 89 ee 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d e9 14 89 7a f6 e8 ff 80 0a f6 90 <0f> 0b 90 48 8b 44 24 10 42 0f b6 04 30 84 c0 0f 85 c8 01 00 00 41
> RSP: 0018:ffffc90003b3ee68 EFLAGS: 00010293
> RAX: ffffffff8bbd5b01 RBX: 000000000000ffff RCX: ffff8880780bbe80
> RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
> RBP: 000000000000004c R08: 0000000000000001 R09: 0000000000000011
> R10: 000000000000001f R11: 0000000000000000 R12: ffff888071cdbd36
> R13: ffff88802d028396 R14: dffffc0000000000 R15: ffff888071cdbc80
> FS:  0000555579c36400(0000) GS:ffff888124dc5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd90696af0 CR3: 000000007065a000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   set_ipv6 net/openvswitch/actions.c:531 [inline]
>   execute_masked_set_action net/openvswitch/actions.c:1073 [inline]
>   do_execute_actions+0x557e/0x8600 net/openvswitch/actions.c:1366
>   ovs_execute_actions+0xde/0x520 net/openvswitch/actions.c:1592
>   ovs_packet_cmd_execute+0xb4f/0xf10 net/openvswitch/datapath.c:705
>   genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
>   genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
>   genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
>   netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
>   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>   netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>   netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
>   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
>   sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
>   __sock_sendmsg net/socket.c:818 [inline]
>   ____sys_sendmsg+0x54e/0x850 net/socket.c:2715
>   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2769
>   __sys_sendmsg net/socket.c:2801 [inline]
>   __do_sys_sendmsg net/socket.c:2806 [inline]
>   __se_sys_sendmsg net/socket.c:2804 [inline]
>   __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2804
>   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>   do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe073a4fd39
> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffece969af8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007ffece969c28 RCX: 00007fe073a4fd39
> RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 00007ffece969c28 R09: 00007ffece969c28
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffece969c18
> R13: 0000000000000002 R14: 00007fe073ae0ca0 R15: 0000000000000002
>   </TASK>
> 
> 

Hi,

I have a fix for this trace. I have verified it with the reproducer but 
I want to do a more testing before sending it, so will send it tomorrow.

In addition, I am not so sure about how likely can this be hit in a 
production environment.. as fragmentation isn't common and conntrack 
auto-reassembly should kick in.. pretty edge-case in my opinion.

Thanks,
Fernando.

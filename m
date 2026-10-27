Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123129;
	b=iGbdCswl8EeN0cy26UwWhTFZORssx9+clTC30M+Yo5ha3s2k/LTxiZ2DBDC1XfXd98xR
	 5WIBlZ8j6V6VS5w5JTRjTGPMzPV64zYJCurh7/Z5E1RirPZE47Xjt58ND0b269oz9dQ3u
	 Zj4oFQW3oYTYWVJspdMhuyTqpZEARnXKqYnTX0/qMZr/5HagQrxQf4D8Mappwp0q4dUoI
	 W5LyQ0Q87DDn0XQhMeEu8yUDWsI16M0lTTkUVZaxD/NUEaPYR0tPCIa3QT7q+DLA4hOrK
	 rJTLSOQTSvY5txKDtX9sTgqsxaYr3N5Cep3QINUUbfakCGCxttCKpwBnr5J05kOXGnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TUZLI4QB1UybDVdO2XLadWlUwZ9bhjbLKupN4zoERa0=;
	b=T12HPL6FCo6lZYBP2HPoCJuWsPQcCXvnd1K+riZ3EdNOQyMx2ue93geieoRfx7v+pMb7
	 naXLjcw9IjATv0YlSJyYRE0eh3sWAU6v/ddPpYnQTxbLisDh+rj7ySKXPC/crmG820AvW
	 8VjVoMmBfLKQ7xyILcBIpP35jCxv6yJMv0wkiRkP6KrgR3L4QTo44ykHB8FVeT6sud4OA
	 2Nka11m0Msa/R5HfvtENRZbtFjwV5eMLwhrlx0961iZ7J7rsviYmfHfARG3P7KomZNrOV
	 ALszO8TcvGWw5s3suYhVN4l8+Zap9iMysoI7TmK3k4b9RQDg3XTy3ErlvJMUlbiuxnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=H1X53Caf;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD35606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 17:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD35606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=H1X53Caf
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e46e449e8so71359f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793123127; x=1793727927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TUZLI4QB1UybDVdO2XLadWlUwZ9bhjbLKupN4zoERa0=;
        b=H1X53CafUWasCx76oRCeY0MZiU6CyFNN3d58SNxbEPmOhO0DY6xWf1rDIal2i+utMV
         fG3vyLlYFgSBECHpbAxvH8BubMV6IM6qmFATLG4C3syy3kgNk0pM1ZPLxy6l108edjfD
         1xu2D86EU8ikO99FyX/PdmAEfXXsza2meuMIy2lk1Ga1wTfPFRdXqjwFEoFAVaQsJrC3
         vahrGV63XbYm8cZL1htu9/Icu25odTXt8KATh00yzH6t3WXRsZ4t9fC09YFWysSbNDUU
         T4JbQEoHVVuJuO0zDY/BWpHy1ha4Q8NInRppJInhUdvCd7TDKzcMFDDLKqebtCExYvpQ
         lT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123127; x=1793727927;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUZLI4QB1UybDVdO2XLadWlUwZ9bhjbLKupN4zoERa0=;
        b=UiNwsjsxlzj8rIZCLISPjTJu/fhAN21xXPVHSijccxM5EzhtpkDPMioyV+wZILl615
         qjODos6yWSVx//Wi2UdIslh5Ak89jWlOqMuaCqgKJjqMEVmix4nu4QXYvq+BP9NyqJM0
         JiOMrOE0FfIrB25Z0Iaf8ccO8P03svJ+f2QZNH8mNB5cDPOd+nx0w9/FMi8MCX39RqLF
         Ww+pqHn/pFuB5WBnTfs05bdht0FqRrKKMg+yRyUdhkDPDpcJJgh98lQYhZmDAYs/CEUD
         b1hd0gajzaq0E58CXhtIbqwvkaY7q6sZRHkSbhUylO9f9NmZR3KYZ8nSWNz+x6Wkc6Lc
         PMYw==
X-Forwarded-Encrypted: i=1; AKwUvByRJ1E5qiZwdieY7IAvf1KjFV0CHK/1sv+iwX6yBkdU3u3tlfo37G0xmHZJa4O+IYZMrlkhk20=@vger.kernel.org
X-Gm-Message-State: AFq9FYItyLfzEUWgYzNM83txVl0RwBBcB9saehDF0ch5QSHJ87QrWM8u
	1gxI6Zy0BHWgfNil7v9LFH+9SWVF0lhI3GoW9ivIsiUM+FCNO/tz1HWEixucGsc7VMw=
X-Gm-Gg: AYBFou0dk4JN/ey/G2fPjypnY7jv4JR+YOggHkkIcVwsWQtRTb173WNWrUeLU0rr64K
	L4s2I0CPcwqYydj7FJc5bn6Ryk2FGmPQgFBlkdxudUXg/p3Sie1GcyaQiTPighmspJSZ7A0MJme
	BwyLsGl7E0yq1MvMwpskh45vtshwOHXco+nHppQEFyBm4X4O/y1iSaDSm3DOnJT3ZrR26dMoKE9
	1kocm6glbHZTir5llmYA1Up2brHd+an032Rhiim5B9IGbPavspR3yTHCpJNtXKSKXMY+wh+6n1f
	05wmywquCOu/xROAmxwcjsC457Kltj7Z4SuieDDSfVyLW/ANBzkaOnkjSF7nt1WpekVHrIoZMvG
	newSt6Qxm5RncBYkUaEfsKzUhNppFI2vq9nOCcvOQQpBXDPvsIu0ifZSB/3MiwFBaAXnsQ5baG3
	2meVUw/+D18BjLJVG1TN0BpyUNod7mTgvFD5UNNPaxRdTwvxL15uJV9cFhP1mZi3mjlQo7+P4TC
	8fYKzDPMI4TE4TKo70xpXL09L2E4vIcD0fqlSMhCKXXXB8KflZsmER7PyE=
X-Received: by 2002:a05:6000:1a8e:b0:48e:43a:1d84 with SMTP id ffacd0b85a97d-48e5d2f1cbbmr489290f8f.23.1793123126853;
        Tue, 27 Oct 2026 10:45:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f37csm19540091f8f.8.2026.10.27.10.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:45:26 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:45:24 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>, chris@chrisdown.name,
	Sam Crossley <samuelcrossley@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer on
 demand
Message-ID: <auDjNKi336lstU7j@pathway.suse.cz>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de>
 <at84qygscue8crQi@gmail.com>
 <87a4o0k3qa.fsf@jogness.linutronix.de>
 <at9qgBucVm-QHnye@pathway.suse.cz>
 <87zew0ifpp.fsf@jogness.linutronix.de>
 <at-Ppa86sBw7mO8W@gmail.com>
 <auCraiuMZApQHiNA@pathway.suse.cz>
 <auDETo3ot3enCEv_@gmail.com>
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
In-Reply-To: <auDETo3ot3enCEv_@gmail.com>

On Tue 2026-10-27 08:54:12, Breno Leitao wrote:
> On Tue, Oct 27, 2026 at 02:47:22PM +0100, Petr Mladek wrote:
> > On Mon 2026-10-26 10:49:32, Breno Leitao wrote:
> > > A bit of context on the use case from our side.
> > > 
> > > In an ideal world netconsole is enabled from early boot through the
> > > kernel command line, but in some case this is impossible
> > > (linux as bootloaders - ipxe/sd-stubs/etc).
> > > 
> > > The other way to setup netconsole is to create a new target at runtime
> > > through configfs. Netconsole then only sends messages from the time the
> > > target is enabled.
> > > 
> > > For this second case, I would like to replay the whole kernel log on
> > > netconsole, such as previous messages. Something might have happened
> > > before the target was enabled, and we want visibility into that.
> > 
> > Just to be sure that I understand it correctly. 
> > 
> > Is the netconsole registered before it gets functional, please?
> 
> Correct. The console is registered at module load time, in
> init_netconsole(), before any target is created.
> 
> In other words, a single console is registered at module load, and the
> netconsole targets are then handled under that same console.

I see.

> > Is it possible to detect that the netconsole is not yet functional
> > and when it could start working?
> >
> > I ask because there is the flag CON_PRINTBUFFER which should cause
> > re-playing all messages on the console during registration.
> > 
> > A solution might be to delay the console registration until
> > the netwok target is really working.
> 
> Yes, we can register the console when the target is enabled. However, I
> think the user will need to choose whether the console is registered
> with CON_PRINTBUFFER or not, since in some cases they only want messages
> from the moment the target is enabled.

It is more complicated then. IMHO, this patchset does not work
as expected. The 1st patch does:

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3494,13 +3494,14 @@ void console_unblank(void)
 }
 
 /*
- * Rewind all consoles to the oldest available record.
+ * Rewind a console, or all consoles if @target is NULL, to the oldest
+ * available record.
  *
  * IMPORTANT: The function is safe only when called under
  *            console_lock(). It is not enforced because
  *            it is used as a best effort in panic().
  */
-static void __console_rewind_all(void)
+static void __console_rewind(struct console *target)
 {
 	struct console *c;
 	short flags;
@@ -3511,6 +3512,9 @@ static void __console_rewind_all(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
+		if (target && c != target)
+			continue;
+
 		flags = console_srcu_read_flags(c);
 
 		if (flags & CON_NBCON) {

Note that the filtering is done by struct console *target.
And it resets con->nbcon_seq for this structure.

But the "target" in netconsole_write() is struct netconsole_target *nt.

By other words, the messages will be replayed on all netconsole
targets associated with the given struct console. But you want
to replay it only on a particular netconsole_target.

> So we would probably need one console per netconsole target?

This might be the right solution. But it would require some
support in the register_console() and maybe in
__add_preferred_console() machinery.

The console registration code is a historical mess.
I am trying to clean this up a bit, see
https://lore.kernel.org/all/20260929120546.328616-1-pmladek@suse.com/
But it just a beginning. The code will be hairy even with this patchset.

The following problems come to my mind:

  1. The information about preferred consoles is stored into
     a static array console_cmdline[MAX_CMDLINECONSOLES].
     It is currently limited to 8 entries. I am not sure
     how much netconsole targets people use.

     We might need to create one entry for each netconsole
     target.

     Alternative solution might be to implement con->match()
     callback which would be able to share a single
     console_cmdline entry for all netconsole targets.

     Note that the ->match() callback was added to match
     real console driver with a boot console driver.
     But it should be usable to match a netconsole target
     as well.


  2. AFAIK, all console drivers are currently using a statically
     defined struct console. But we might need to allocate
     one for each netconsole target dynamically. It might
     require revisiting/adding a code for handling the
     lifetime of the structure.

     But it should be doable.


> > Another solution might be to temporary block/disable the console
> > until it gets operational. We already have console_suspend()/resume()
> > API. But we might need something new to distinguish it from
> > the system suspend/resume handling.
> 
> In that case, what happens to the console while it is suspended?

The suspended console gets stalled and the related con->nbcon_seq
stays where it is. The pending messages are flushed when the console
gets resumed.


> > > That said, the "per-console counter" might work as well, since it would
> > > start as 0, thus, we know that netconsole target would be behind, and
> > > try to replay? (not sure how yet)
> > 
> > This is what the console_try_replay_all() does. The only difference
> > is that it resets the counter to the oldest available message,
> > see __console_rewind_all(). It is just a small optimization
> > when the ring buffer is already full and the oldest messages
> > are gone.
> 
> Right, but that would apply to all consoles, while in our case we only
> want to replay the log on a specific console (netconsole).

As explained above. It is even more complicated because there
might be more netconsole_target pointers for the single
struct console netconsole.

I suggest to investigate the way with the custom ->match()
callback and dynamically allocated per-netconsole target
struct console. It would allow to have per-netconsole-target
con->nbcon_seq counter and keep the netconsole target details
in netconsole code.

You might want to wait for John's opinion before you spend
to much time on this. It is possible that I miss some
obvious problem.

Best Regards,
Petr

PS: Feel free to ask for more details. Just note that there is a public
    holiday here tomorrow. I will not be able to react before Thursday.

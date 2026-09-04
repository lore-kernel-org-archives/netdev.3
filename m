Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19C274FD1
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519664; cv=none; b=UOPh8UtV3TXoab6AkQJmg+ss6zKLy4q/uP1MHeStUWgAYBYWkBcm0zpQWOSPWjMRxo4zYLBgW5am8ubwzaddhWdIsvOTDFL2qI2pOZEoVi3jkcefNn8P/aHlK/vwpkGCVmsuf0sbOEy5mlbCe+mGLMz1p0jOQgt+3lmRk4HjLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519664; c=relaxed/simple;
	bh=19Fo65Qlz2zTbc7pRIvQUfABKgthgHG+fUxEY+FLUQA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1DJ+uaBtEvO6Becct1LvxWL1zVPlSNy2SzWeOz+xGPYSvd5C+pWlC0NrO0RgxkTE8zLlZTUXk8EGS3e5UjUB9jY8WQXFtEXf4ngJIz7d4g5gcmzjc8n8Z5Gsp18eTkTqeRs1F97BRL5aWhWBVacX/w+AGvZUboVHAp/qMb7sd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQmh6+Bz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQmh6+Bz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AED1F00A3E;
	Fri,  4 Sep 2026 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519662;
	bh=lSv+wnqWG9X60KQnULWcnjEFamRYLv4xIywhCkAEZH8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YQmh6+BzHnt/e9YKRiYSkpjI0r/knvEXjjHyis7W2isOl/VSk1tNLgj/Q0lJlK86P
	 HCjt9vSvlo90nzrBQgYKkL/SG0ebDR+U4QRZ9I06OjaA2bl66ABHYKxExqVJVyDMGu
	 GMJR+YXmxEXxtTLkBBqDnITTg2T6sQ8dba9nstyE5mn3RrJUzqN1mdFy59eJnEyOjd
	 NEDBExhfgKTi8HTVT+iiNcx7xSL3Zl9vAKGNCeGp3S2pJxnyEtdiJ43EnnYlzEm5G6
	 O+Qyct+5kMkcODX5jbHNjECEwSb+0yJ0RLPDEnaBkY6VgEXPqLF6raa0nCs+ECzYSL
	 lNvLz9u60p+ug==
Subject: Re: [PATCH v2 net] selftests/tc-testing: pass mp_pm via initialiser
From: netdev-bot+sashiko@kernel.org
To: fw@strlen.de
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 victor@mojatatu.com, kuba@kernel.org
Date: Fri, 04 Sep 2026 11:01:00 +0000
Message-ID: <178851966096.4131868.12758868968085843124@kernel.org>
In-Reply-To: <20260903103621.13160-1-fw@strlen.de>
References: <20260903103621.13160-1-fw@strlen.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] run_one_test() (tools/testing/selftests/tc-
  testing/tdc.py:394-401) rebuilds the per-test substitution dictionary…
- [Low] The new comment in test_runner_mp() (tdc.py:617-618) states "Use
  the 'initializer' to pass the unpickleable/shared objects to each…
- [Low] The commit fixes two independent, user-visible breakages and
  carries no `Fixes:` tag for either, and squashes them into a single…

--

selftests/tc-testing: pass mp_pm via initialiser

This passes pm and args to the multiprocessing workers via
Pool(initializer=...) instead of relying on module globals, and stops
run_one_test() from mutating the module-global NAMES dictionary by
building a per-test copy in args.NAMES. Readers of the substitution
dictionary are converted to args.NAMES.

No Link: tags in the commit header.

> diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
> index 511d66c36a2a..7c7f96aaef55 100755
> --- a/tools/testing/selftests/tc-testing/tdc.py
> +++ b/tools/testing/selftests/tc-testing/tdc.py

[ ... ]

> @@ -206,7 +206,7 @@ def exec_cmd(caseinfo, args, pm, stage, command):
>      if len(command.strip()) == 0:
>          return None, None
>      if '$' in command:
> -        command = replace_keywords(command)
> +        command = replace_keywords(command, args.NAMES)
>  
>      command = pm.call_adjust_command(caseinfo, stage, command)
>      if args.verbose > 0:

[ ... ]

> @@ -396,6 +391,15 @@ def run_one_test(pm, args, index, tidx):
>              pm.call_post_execute(tidx)
>              return res
>  
> +    # populate NAMES with TESTID for this test
> +    args.NAMES = NAMES.copy()
> +    args.NAMES['TESTID'] = tidx['id']
> +    args.NAMES['NS'] = '{}-{}'.format(NAMES['NS'], tidx['random'])
> +    args.NAMES['DEV0'] = '{}id{}'.format(NAMES['DEV0'], tidx['id'])
> +    args.NAMES['DEV1'] = '{}id{}'.format(NAMES['DEV1'], tidx['id'])
> +    args.NAMES['DUMMY'] = '{}id{}'.format(NAMES['DUMMY'], tidx['id'])
> +    args.NAMES['IFB'] = '{}id{}'.format(NAMES['IFB'], tidx['id'])
> +

[Severity: Medium]
Should this copy start from args.NAMES rather than from the module-global
NAMES?

In a worker process the module-global NAMES is the pristine dict imported
from tdc_config.py, because with a non-fork start method the worker
re-imports tdc.py as __mp_main__.  That is exactly the situation the first
half of this patch addresses: the reported "NameError: name 'mp_pm' is not
defined" only happens because the child does not inherit parent module
state.

The only place -p/--path and -d/--device are applied is
check_default_settings(), which runs in the parent only:

    if args.path != None:
        NAMES['TC'] = args.path
    if args.device != None:
        NAMES['DEV2'] = args.device

The configured dict does reach the worker as args.NAMES through
initargs=(pm, args), and run_one_test() then discards it with
args.NAMES = NAMES.copy().

So for "tdc.py -J4 -p /my/build/tc", do the parallel tests end up running
/sbin/tc instead of the requested binary?  The parent validated args.path,
not /sbin/tc, so if /sbin/tc is missing the parallel tests would all fail.

Similarly with -d <nic>: in the worker args.device stays set while
args.NAMES['DEV2'] is '', so $DEV2 expands to nothing and
nsPlugin._ipr2_ns_create_cmds() emits commands like

    link set  netns <ns>
    netns exec <ns> $IP link set  up

which iproute2 rejects and _proc_check() turns into a RuntimeError.

Also, exec_cmd() still reads the module-global dict for the timeout:

    (rawout, serr) = proc.communicate(timeout=NAMES['TIMEOUT'])

while its substitution path now uses args.NAMES.  Should that reader be
converted too, so there is a single source of truth inside a worker?

One note on the shape of a fix: args.NAMES = args.NAMES.copy() would not
work, since args.NAMES is reassigned per test and would re-accumulate the
id<ID> suffixes this patch removes.  Keeping a pristine copy of the
configured names (for example on args, or passed through __mp_init__) and
deriving each test's dict from that would avoid both problems.

[ ... ]

> @@ -600,6 +587,18 @@ def mp_bins(alltests):
>  
>      return (serial, parallel)
>  
> +mp_pm = None
> +mp_args = None
> +
> +def __mp_init__(pm, args):
> +    """
> +    This function is called once when each worker process starts.
> +    It sets the global variables in the child process's memory space.
> +    """
> +    global mp_pm, mp_args
> +    mp_pm = pm
> +    mp_args = args
> +
>  def __mp_runner(tests):
>      (_, tsr) = test_runner(mp_pm, mp_args, tests)
>      return tsr._testsuite
> @@ -615,14 +614,13 @@ def test_runner_mp(pm, args, alltests):
>      print("Executing {} tests in parallel and {} in serial".format(len(parallel), len(serial)))
>      print("Using {} batches and {} workers".format(len(batches), args.mp))
>  
> -    # We can't pickle these objects so workaround them
> -    global mp_pm
> -    mp_pm = pm
> -
> -    global mp_args
> -    mp_args = args
> -
> -    with Pool(args.mp) as p:
> +    # Use the 'initializer' to pass the unpickleable/shared objects
> +    # to each worker process exactly once upon startup.
      ^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Is the word "unpickleable" right here?  With forkserver or spawn,
multiprocessing serialises the worker bootstrap payload, initargs
included, so pm and args have to be picklable for this to work at all.
If they really were unpicklable, Pool() would raise in the parent before
__mp_init__() ever ran, and the run would abort with zero tests executed.

The baseline comment said the opposite ("We can't pickle these objects so
workaround them"); could the new comment say that pm and args are now
required to be picklable, so the requirement is visible to whoever adds
the next plugin?

I checked the objects currently shipped and they do pickle: tdc.py
registers its module-level identity() via
parser.register('type', None, identity), and nsPlugin's cached_property
_proc (a subprocess.Popen) is not materialised before Pool() is created,
since prepare_run() -> call_pre_suite() only records testcount/testlist.
So there is no failure today.  A plugin from plugin-lib-custom or
$TDC_PLUGIN_DIR that caches a Popen or a socket in pre_suite() would
break -J only on newer Python versions.

Could the changelog also name the root cause, that Python 3.14 changed
the default start method on Linux from fork to forkserver, so the old
global mp_pm inheritance no longer works?  As written, a backporter
cannot tell that the failure is Python-version dependent.

> +    with Pool(
> +        processes=args.mp,
> +        initializer=__mp_init__,
> +        initargs=(pm, args)
> +    ) as p:
>          pres = p.map(__mp_runner, batches)

[Severity: Low]
Could this be split into two patches, each with a Fixes: tag?

The two problems have separate origins.  The -J NameError comes from the
global mp_pm/mp_args workaround and the test_runner(mp_pm, mp_args, tests)
call in __mp_runner(), added by ac9b829309646 ("selftests/tc-testing:
implement tdc parallel test run").

The doubly-suffixed names such as dummy0id1234idabcd come from the
mutate-the-global-and-restore pattern in run_one_test() (the
ns = NAMES['NS'] ... ifb = NAMES['IFB'] save and the restore at the end),
added by 98cfbe4234a41, with the IFB entry added later by 4177fd4469824.
The restore is skipped whenever prepare_env() raises PluginMgrTestFail,
since test_runner() breaks out of the loop, and the worker process is then
reused for the next batch with the suffixed names still in the global.

As one patch, a maintainer cannot pick up the multiprocessing initializer
fix without also taking the NAMES ownership rework.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903103621.13160-1-fw%40strlen.de
